import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:college_tinder/screens/login/otpScreen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';

class PhoneSignupScreen extends StatefulWidget {
  const PhoneSignupScreen({super.key});

  @override
  State<PhoneSignupScreen> createState() => _PhoneSignupScreenState();
}

class _PhoneSignupScreenState extends State<PhoneSignupScreen> {
  Country? selectedCountry;
  @override
  Widget build(BuildContext context) {
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
              "Please enter your valid phone number. We will send you a 4-digit code to verify your account. ",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black),
            ),

            SizedBox(height: 40,),

            Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      width: 1.2, color: Colors.grey.withOpacity(0.2))),
              child: Center(
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                            bottomSheetHeight: 500, // Optional. Country list modal height
                            //Optional. Sets the border radius for the bottomsheet.
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            //Optional. Styles the search field.
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
                          onSelect: (Country country){
                            selectedCountry=country;
                            setState(() {

                            });
                          },
                        );
                      },

                      child: Row(
                        children: [
                          Text(selectedCountry?.flagEmoji??"",style: TextStyle(fontSize: 25),),
                          Text(" (+${selectedCountry?.phoneCode??"+91"}) "),
                          Icon(Icons.arrow_drop_down),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                            child: VerticalDivider(),
                          ),
                          Container(
                            width: 200,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "1234567890",
                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.2))
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
              child: InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>const OtpScreen()));

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
