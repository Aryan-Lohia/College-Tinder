import 'package:college_tinder/common/components/navbar.dart';
import 'package:college_tinder/common/global.dart';
import 'package:college_tinder/screens/feed/feedScreen.dart';
import 'package:college_tinder/screens/matches/matches.dart';
import 'package:college_tinder/screens/messages/messagesScreen.dart';
import 'package:college_tinder/screens/profile/profileScreen.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final List<Widget> screens=[
    Feedscreen(),
MatchesScreen(),
Messagesscreen(),
    ProfileScreen(),  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 80,
        width: MediaQuery.of(context).size.width,
        child: ValueListenableBuilder(
            valueListenable: selectedScreen, builder: (context, value, __) {
              return Center(child:screens[value]);
        }),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
