import 'package:country_picker/country_picker.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/components/pinCodeField.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  @override
  _ChangePhoneNumberScreenState createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  PinTheme pinTheme = PinTheme(
    keysColor: Colors.black,
  );
  String? _verificationId;
  bool _isVerifying = false;
  Country? selectedCountry;
  String phoneNumber = "";
  bool isLoading = false; // To handle loading state
  bool _isOtpSent = false;

  void _sendOtp() async {
    setState(() => _isOtpSent = false);

    await _auth.verifyPhoneNumber(
      phoneNumber: '+${selectedCountry!.phoneCode}$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.currentUser?.updatePhoneNumber(credential);
        setState(() => _isOtpSent = false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Phone number updated successfully!")));
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _isOtpSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

   _verifyOtp(
    String code,
  ) async {
    if (_verificationId != null) {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );

      try {
        await _auth.currentUser!.updatePhoneNumber(credential);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Phone number updated successfully!")));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Verification failed: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Phone Number")),
      body: Column(
        children: [
          if (!_isOtpSent)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "My Mobile",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                  const Text(
                    "Please enter your valid phone number. We will send you a 4-digit code to verify your account.",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 70,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 1.2, color: Colors.grey.withOpacity(0.2))),
                    child: Center(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                  flagSize: 25,
                                  backgroundColor: Colors.white,
                                  textStyle: TextStyle(
                                      fontSize: 16, color: Colors.blueGrey),
                                  bottomSheetHeight: 500,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                ),
                                onSelect: (Country country) {
                                  setState(() {
                                    selectedCountry = country;
                                  });
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(selectedCountry?.flagEmoji ?? "",
                                    style: TextStyle(fontSize: 25)),
                                Text(
                                    " (+${selectedCountry?.phoneCode ?? "91"}) "),
                                Icon(Icons.arrow_drop_down),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10),
                                  child: VerticalDivider(),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: TextField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.phone,
                                    onChanged: (value) {
                                      setState(() {
                                        phoneNumber = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "1234567890",
                                      hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.2)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _sendOtp,
                    child: Text("Send OTP"),
                  ),
                ],
              ),
            ),
          if (_isOtpSent)
            Container(
              height: MediaQuery.sizeOf(context).height / 1.8,
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      if (code.length == 6) {
                        try {
                          await _verifyOtp(code);
                        } catch (e) {
                          // Handle error (e.g., show a dialog)
                          print("Error verifying OTP: $e");
                        }
                      }
                    },
                    specialKeyOnTap: () {},
                    maxLength: 6,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
