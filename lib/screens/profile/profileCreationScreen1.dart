import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:college_tinder/screens/profile/profileCreationScreen2.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '';

import '../../common/components/datePicker.dart';
import '../../common/components/pinCodeField.dart';

class ProfileCreationScreen1 extends StatefulWidget {
  const ProfileCreationScreen1({super.key});

  @override
  State<ProfileCreationScreen1> createState() => _ProfileCreationScreen1State();
}

class _ProfileCreationScreen1State extends State<ProfileCreationScreen1> {
  DateTime selectedDate = DateTime(1995, 7, 11);

  void _openDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: BottomSheetDatePicker(
            initialDate: selectedDate,
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
        );
      },
    );
  }

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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              const ProfileCreationScreen2()));
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
            Spacer(),
            const Text(
              "Profile Details",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black),
            ),
            SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                height: 105,
                width: 105,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/defaultProfilePhoto.png"),
                                  fit: BoxFit.cover))),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffe94057),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 15,
                              ))),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                cursorColor: Colors.grey,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "First Name",
                    labelStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                cursorColor: Colors.grey,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Last Name",
                    labelStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => _openDatePicker(context),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color(0xffe94057).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Color(0xffe94057),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Choose Birthday date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xffe94057)),
                        ),
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                const ProfileCreationScreen2()));
                  },
                  child: MainButtonDesign(text: "Confirm")),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
