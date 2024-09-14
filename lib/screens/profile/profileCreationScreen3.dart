import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:college_tinder/screens/permissions/permissions.dart';
import 'package:college_tinder/screens/profile/profileCreationScreen3.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '';

import '../../common/components/datePicker.dart';
import '../../common/components/pinCodeField.dart';

class ProfileCreationScreen3 extends StatefulWidget {
  const ProfileCreationScreen3({super.key});

  @override
  State<ProfileCreationScreen3> createState() => _ProfileCreationScreen3State();
}

class _ProfileCreationScreen3State extends State<ProfileCreationScreen3> {
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

  // Store the selected items' indices.
  List<int> selectedHobbies = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>const ContactsPermissionsScreen()));

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
              height: 30,
            ),
            const Text(
              "Your interests",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black),
            ),const Text(
              "Select a few of your interests and let everyone know what you’re passionate about.",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
        Container(
          height: MediaQuery.of(context).size.height*0.5,
        child:
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(10.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
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
                    selectedHobbies.remove(index); // Deselect the hobby
                  } else {
                    selectedHobbies.add(index); // Select the hobby
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
          },)),
            InkWell(
              onTap:(){
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>const ContactsPermissionsScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40,20,0),
                child: MainButtonDesign(text: "Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}