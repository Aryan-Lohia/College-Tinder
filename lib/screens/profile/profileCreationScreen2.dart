import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:college_tinder/screens/profile/profileCreationScreen3.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '';

import '../../common/components/datePicker.dart';
import '../../common/components/pinCodeField.dart';

class ProfileCreationScreen2 extends StatefulWidget {
  const ProfileCreationScreen2({super.key});

  @override
  State<ProfileCreationScreen2> createState() => _ProfileCreationScreen2State();
}

class _ProfileCreationScreen2State extends State<ProfileCreationScreen2> {
  int selectedGender = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color getBoxColorByIndex(int index) {
    if (selectedGender == index) {
      return Color(0xffe94057);
    }
    return Colors.white;
  }

  Color getBoxBorderColorByIndex(int index) {
    if (selectedGender == index) {
      return Color(0xffe94057);
    }
    return Colors.grey.withOpacity(0.5);
  }

  Color getTextColorByIndex(int index) {
    if (selectedGender == index) {
      return Colors.white;
    }
    return Colors.black;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Image.asset("assets/backButton.png"),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>const ProfileCreationScreen3()));

                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xffe94057)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            const Text(
              "I am a",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black),
            ),
            SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () {
                selectedGender = 0;
                setState(() {});
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  decoration: BoxDecoration(
                      color: getBoxColorByIndex(0),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: getBoxBorderColorByIndex(0), width: 0.5)),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Woman",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: getTextColorByIndex(0)),
                        ),
                        Spacer(),
                        Icon(
                          Icons.check,
                          color: getTextColorByIndex(0),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              splashFactory: NoSplash.splashFactory,
              enableFeedback: false,
              onTap: () {
                selectedGender = 1;
                setState(() {});
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  decoration: BoxDecoration(
                      color: getBoxColorByIndex(1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: getBoxBorderColorByIndex(1), width: 0.5)),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Man",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: getTextColorByIndex(1)),
                        ),
                        Spacer(),
                        Icon(
                          Icons.check,
                          color: getTextColorByIndex(1),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                selectedGender = 2;
                setState(() {});
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  decoration: BoxDecoration(
                      color: getBoxColorByIndex(2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: getBoxBorderColorByIndex(2), width: 0.5)),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Other",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: getTextColorByIndex(2)),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.check,
                          color: getTextColorByIndex(2),
                        ),
                      ],
                    ),
                  )),
            ),
            Spacer(),
            InkWell(
              onTap:(){
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>const ProfileCreationScreen3()));

              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: MainButtonDesign(text: "Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
