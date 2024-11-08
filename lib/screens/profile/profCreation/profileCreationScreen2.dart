import 'dart:convert';

import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:college_tinder/screens/profile/profCreation/profileCreationScreen3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../secrets.dart';
import '../../login/backend.dart';

class ProfileCreationScreen2 extends StatefulWidget {

  const ProfileCreationScreen2({super.key});

  @override
  State<ProfileCreationScreen2> createState() => _ProfileCreationScreen2State();
}

class _ProfileCreationScreen2State extends State<ProfileCreationScreen2> {
  int selectedGender = 0;
  Future<void> _sendData() async {
    final authProvider = Provider.of<Authentication>(context, listen: false);
    final url = '${Secret.BASE_URL}/users/update'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};


    final body = jsonEncode({
      "auth_id":authProvider.userProfile!.authId,
      'gender': selectedGender,
      "onboarding_completed":2,

    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        // Handle successful response
        Navigator.push(context, CupertinoPageRoute(builder: (context) => const ProfileCreationScreen3()));
      } else {
        // Handle error response
        Fluttertoast.showToast(
          msg: "Check your internet and try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print('Failed to submit data: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
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

  Future<void> _onContinue() async {
    // Add the selected gender to the userData
    await _sendData();
    // Navigate to the next screen with the updated user data

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
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ProfileCreationScreen3(),
                      ),
                    );
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xffe94057),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 80),
            const Text(
              "I am a",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 80),
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
                    color: getBoxBorderColorByIndex(0),
                    width: 0.5,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Woman",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: getTextColorByIndex(0),
                        ),
                      ),
                      Spacer(),
                      selectedGender==0?Icon(
                        Icons.check,
                        color: getTextColorByIndex(0),
                      ):Container(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
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
                    color: getBoxBorderColorByIndex(1),
                    width: 0.5,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Man",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: getTextColorByIndex(1),
                        ),
                      ),
                      Spacer(),
                      selectedGender==1?Icon(
                        Icons.check,
                        color: getTextColorByIndex(1),
                      ):Container(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
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
                    color: getBoxBorderColorByIndex(2),
                    width: 0.5,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Other",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: getTextColorByIndex(2),
                        ),
                      ),
                      const Spacer(),
                      selectedGender==2?Icon(
                        Icons.check,
                        color: getTextColorByIndex(2),
                      ):Container(),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: _onContinue,
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
