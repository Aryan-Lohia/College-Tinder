import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:college_tinder/screens/homeLayout/homeLayout.dart';
import 'package:college_tinder/screens/profile/profileCreationScreen2.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '';

import '../../common/components/datePicker.dart';
import '../../common/components/pinCodeField.dart';

class NotificationsPermissionsScreen extends StatefulWidget {
  const NotificationsPermissionsScreen({super.key});

  @override
  State<NotificationsPermissionsScreen> createState() => _NotificationsPermissionsScreenState();
}

class _NotificationsPermissionsScreenState extends State<NotificationsPermissionsScreen> {


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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                          const HomeLayout()),(Route<dynamic> route) => false);
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xffe94057)),
                ),
              ),
            ),
            SizedBox(height: 80,),
            Image.asset("assets/permissions/chat.png"),
            SizedBox(height: 60,),
            Text(
              "Enable Notifications",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            SizedBox(height: 10,),

            Text(
              "Get push-notification when you get the match or receive a message.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black),
            ),
            Spacer(),
            InkWell(
              onTap:(){
                Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context)=>const HomeLayout()),(Route<dynamic> route) => false);
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
class ContactsPermissionsScreen extends StatefulWidget {
  const ContactsPermissionsScreen({super.key});

  @override
  State<ContactsPermissionsScreen> createState() => _ContactsPermissionsScreenState();
}

class _ContactsPermissionsScreenState extends State<ContactsPermissionsScreen> {


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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                          const NotificationsPermissionsScreen()));
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xffe94057)),
                ),
              ),
            ),
            SizedBox(height: 80,),
            Image.asset("assets/permissions/people.png"),
            SizedBox(height: 60,),
            Text(
              "Search friend’s",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            SizedBox(height: 10,),

            Text(
              "You can find friends from your contact lists to connected",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black),
            ),
            Spacer(),
            InkWell(
              onTap:(){
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>const NotificationsPermissionsScreen()));
              },

              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40,20,0),
                child: MainButtonDesign(text: "Access to a contact list"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
