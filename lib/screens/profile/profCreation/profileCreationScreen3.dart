
import 'dart:io';

import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:college_tinder/screens/permissions/permissions.dart';
import 'package:college_tinder/screens/profile/profCreation/profileCreationScreen4.dart';
import 'package:college_tinder/secrets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../login/backend.dart'; // For JSON encoding

class ProfileCreationScreen3 extends StatefulWidget {

  const ProfileCreationScreen3({super.key, });

  @override
  State<ProfileCreationScreen3> createState() => _ProfileCreationScreen3State();
}

class _ProfileCreationScreen3State extends State<ProfileCreationScreen3> {


  Future<void> _sendData() async {
    final url = Secret.BASE_URL+'/users/update'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};
    final authProvider = Provider.of<Authentication>(context, listen: false);
    // Upload profile image before sending other data


    final body = jsonEncode({
      "auth_id":authProvider.userProfile!.authId,
      'selectedHobbies': selectedHobbies.map((index) => hobbies[index]['name']).toList(),
      "onboarding_completed":3,
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        // Handle successful response
        Navigator.push(context, CupertinoPageRoute(builder: (context) => const ProfileCreationScreen4()));
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
  final List<Map<String, dynamic>> hobbies = [
    {'name': 'Photography', 'icon': Icons.camera_alt},
    {'name': 'Shopping', 'icon': Icons.shopping_bag},
    {'name': 'Karaoke', 'icon': Icons.mic},
    {'name': 'Yoga', 'icon': Icons.sports_handball},
    {'name': 'Cooking', 'icon': Icons.ramen_dining},
    {'name': 'Tennis', 'icon': Icons.sports_tennis},
    {'name': 'Run', 'icon': Icons.directions_run},
    {'name': 'Swimming', 'icon': Icons.pool},
    {'name': 'Art', 'icon': Icons.palette},
    {'name': 'Traveling', 'icon': Icons.terrain},
    {'name': 'Extreme', 'icon': Icons.diamond},
    {'name': 'Music', 'icon': Icons.music_note},
    {'name': 'Drink', 'icon': Icons.local_bar},
    {'name': 'Video games', 'icon': Icons.sports_esports},
  ];

  List<int> selectedHobbies = [];

  @override
  void initState() {
    super.initState();
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
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const ProfileCreationScreen4()));
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
            SizedBox(height: 30),
            const Text(
              "Your interests",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black),
            ),
            const Text(
              "Select a few of your interests and let everyone know what you’re passionate about.",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black),
            ),
            SizedBox(height: 30),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 3,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: hobbies.length,
                itemBuilder: (context, index) {
                  final hobby = hobbies[index];
                  final isSelected = selectedHobbies.contains(index);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedHobbies.remove(index);
                        } else {
                          selectedHobbies.add(index);
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xffe94057) : Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: isSelected ? Color(0xffe94057) : Colors.grey,
                          width: 2.0,
                        ),
                        boxShadow: isSelected
                            ? [BoxShadow(color: Colors.black12, blurRadius: 5)]
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            hobby['icon'],
                            size: 20.0,
                            color: isSelected ? Colors.white : Color(0xffe94057),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            hobby['name'],
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: _sendData, // Call _sendData when continuing
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40, 20, 0),
                child: MainButtonDesign(text: "Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
