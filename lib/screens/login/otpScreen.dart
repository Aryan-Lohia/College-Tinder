import 'package:college_tinder/screens/profile/profileCreationScreen1.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '';

import '../../common/components/pinCodeField.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(  mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromMinute(1), ); // Create instance.

  TextEditingController controller = TextEditingController();
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
    _stopWatchTimer.dispose();  // Need to call dispose function.

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


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
            final displayTime = StopWatchTimer.getDisplayTime(value!).substring(3,8);
            return Column(
              children: <Widget>[
                Align(alignment: Alignment.centerLeft,child: InkWell(
                  child: Image.asset("assets/backButton.png"),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    displayTime,
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

              ],
            );
          },
        ),

      SizedBox(height: 10,),

            const Text(
              "Type the verification code\n we’ve sent you",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black),
            ),

            SizedBox(height: 50,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
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
              onCompleted: (value){
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>const ProfileCreationScreen1()));

              },
              specialKeyOnTap: () {},
              maxLength: 4,
            ),
            const SizedBox(height: 40),

            Center(
              child: TextButton(
                onPressed: () {

                  setState(() {
                    controller.clear();
                  });
                },
                child: const Text('Send Again',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xffe94057)),),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}
