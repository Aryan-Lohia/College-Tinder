import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:college_tinder/screens/login/otpScreen.dart';
import 'package:college_tinder/screens/login/providers/phone.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For state management
import 'package:fluttertoast/fluttertoast.dart'; // Import fluttertoast

class PhoneSignupScreen extends StatefulWidget {
  const PhoneSignupScreen({super.key});

  @override
  State<PhoneSignupScreen> createState() => _PhoneSignupScreenState();
}

class _PhoneSignupScreenState extends State<PhoneSignupScreen> {
  Country? selectedCountry;
  String phoneNumber = "";
  bool isLoading = false; // To handle loading state

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<PhoneAuthentication>(context, listen: false); // Authentication Provider

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30, 250, 30, 40),
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
                            textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
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
                                  color: const Color(0xFF8C98A8).withOpacity(0.2),
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
                          Text(selectedCountry?.flagEmoji ?? "", style: TextStyle(fontSize: 25)),
                          Text(" (+${selectedCountry?.phoneCode ?? "91"}) "),
                          Icon(Icons.arrow_drop_down),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                            child: VerticalDivider(),
                          ),
                          SizedBox(
                            width: 180,
                            child: TextField(
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                setState(() {
                                  phoneNumber = value;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "1234567890",
                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 80, 30, 30),
              child: isLoading
                  ? Center(child: CircularProgressIndicator()) // Show loading indicator while processing
                  : InkWell(
                onTap: () async {
                  if (phoneNumber.isNotEmpty && selectedCountry != null) {
                    // Add the country code to the phone number
                    final fullPhone = '+${selectedCountry!.phoneCode}$phoneNumber';
                    if(await authProvider.checkIfUserExists(fullPhone, null)){
                      Fluttertoast.showToast(
                        msg: "Number Already Exists. Please try logging in.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      return;
                    }
                    setState(() {
                      isLoading = true; // Start loading
                    });

                    try {
                      // Trigger OTP sending
                      await authProvider.linkPhoneNumber(fullPhone);

                      // Navigate to OTP Screen
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => OtpScreen(phone: fullPhone)),
                      );
                    } catch (e) {
                      // Show toast if phone number already exists or other errors
                      Fluttertoast.showToast(
                        msg: "Failed to send OTP. Please check your phone number.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } finally {
                      setState(() {
                        isLoading = false; // Stop loading
                      });
                    }
                  } else {
                    // Show toast if phone number or country is not selected
                    Fluttertoast.showToast(
                      msg: "Please enter a valid phone number and select your country.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: MainButtonDesign(text: "Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
