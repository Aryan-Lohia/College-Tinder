import 'dart:convert';
import 'package:college_tinder/authWrapper.dart';
import 'package:college_tinder/screens/homeLayout/homeLayout.dart';
import 'package:college_tinder/secrets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:provider/provider.dart';
import '../../common/components/pinCodeField.dart';
import '../profile/profCreation/profileCreationScreen1.dart';
import './providers/phone.dart';
import 'backend.dart'; // Import the Authentication class

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromMinute(1),
  );

  final TextEditingController controller = TextEditingController();
  PinTheme pinTheme = PinTheme(
    keysColor: Colors.black,
  );

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onStartTimer();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.removeListener(() {
      setState(() {});
    });
    controller.dispose();
    _stopWatchTimer.dispose();
    super.dispose();
  }

  void _sendOtpAgain() async {
    final authProvider = Provider.of<PhoneAuthentication>(context, listen: false);
    await authProvider.verifyPhoneNumber(widget.phone,
        resendCode: authProvider.resendCode);
    _stopWatchTimer.onStartTimer();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<PhoneAuthentication>(context);
    final authWrapper = Provider.of<Authentication>(context); // Listen to changes in authProvider

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30, 100, 30, 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: 0,
              builder: (context, snap) {
                final value = snap.data;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value!).substring(3, 8);
                return Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        child: Image.asset("assets/backButton.png"),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        displayTime,
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            const Text(
              "Type the verification code\n we’ve sent you",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 6; i++)
                  PinCodeField(
                    key: Key('pinField$i'),
                    pin: controller.text,
                    pinCodeFieldIndex: i,
                    theme: pinTheme,
                  ),
              ],
            ),
            const SizedBox(height: 40),
            CustomKeyBoard(
              controller: controller,
              pinTheme: pinTheme,
              specialKey: null,
              onCompleted: (value) async {
                final code = value;
                if (code.length == 6 && authProvider.verificationID != null) {
                  try {
                    final userCredential = await authProvider.verifyOTP(
                        code, authProvider.verificationID!);
                    await authWrapper.processCredentials(userCredential);
                  } catch (e) {
                    // Handle error (e.g., show a dialog)
                    print("Error verifying OTP: $e");
                  }
                }
              },
              specialKeyOnTap: () {},
              maxLength: 6,
            ),
            const SizedBox(height: 40),
            Center(
              child: TextButton(
                onPressed: () {
                  if (!_stopWatchTimer.isRunning) {
                    _sendOtpAgain();
                  }
                },
                child: Text(
                  'Send Again',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: _stopWatchTimer.isRunning
                        ? Colors.grey
                        : Color(0xffe94057),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
