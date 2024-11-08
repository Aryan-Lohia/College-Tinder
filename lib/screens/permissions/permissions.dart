import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:college_tinder/screens/homeLayout/homeLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationsPermissionsScreen extends StatefulWidget {
  const NotificationsPermissionsScreen({super.key});

  @override
  State<NotificationsPermissionsScreen> createState() => _NotificationsPermissionsScreenState();
}

class _NotificationsPermissionsScreenState extends State<NotificationsPermissionsScreen> {
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    PermissionStatus status = await Permission.notification.status;
    if (status.isGranted) {
      // Permission already granted, navigate to home screen
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const HomeLayout()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(30, 100, 30, 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                          const HomeLayout()));
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xffe94057)),
                ),
              ),
            ),
            const SizedBox(height: 80,),
            Image.asset("assets/permissions/chat.png"),
            const SizedBox(height: 60,),
            const Text(
              "Enable Notifications",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(height: 10,),
            const Text(
              "Get push-notifications when you get a match or receive a message.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black),
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                PermissionStatus status = await Permission.notification.request();
                if (status.isGranted) {
                  // Permission granted, navigate to home screen
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(builder: (context) => const HomeLayout()),
                  );
                } else {
                  // Handle permission denial
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notification permission is required!')),
                  );
                }
              },
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

class ContactsPermissionsScreen extends StatefulWidget {
  const ContactsPermissionsScreen({super.key});

  @override
  State<ContactsPermissionsScreen> createState() => _ContactsPermissionsScreenState();
}

class _ContactsPermissionsScreenState extends State<ContactsPermissionsScreen> {
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    PermissionStatus status = await Permission.contacts.status;
    if (status.isGranted) {
      // Permission already granted, navigate to notifications permissions screen
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const NotificationsPermissionsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(30, 100, 30, 40),
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
                          builder: (context) => const NotificationsPermissionsScreen()));
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xffe94057)),
                ),
              ),
            ),
            const SizedBox(height: 80,),
            Image.asset("assets/permissions/people.png"),
            const SizedBox(height: 60,),
            const Text(
              "Search friends",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(height: 10,),
            const Text(
              "You can find friends from your contact lists to connect",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black),
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                PermissionStatus status = await Permission.contacts.request();
                if (status.isGranted) {
                  // Permission granted, navigate to notifications permissions screen
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(builder: (context) => const NotificationsPermissionsScreen()),
                  );
                } else {
                  // Handle the case when permission is denied
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Contact permission is required!')),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40, 20, 0),
                child: MainButtonDesign(text: "Access contact list"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class LocationPermissionsScreen extends StatefulWidget {
  const LocationPermissionsScreen({super.key});

  @override
  State<LocationPermissionsScreen> createState() => _LocationPermissionsScreenState();
}

class _LocationPermissionsScreenState extends State<LocationPermissionsScreen> {
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    PermissionStatus status = await Permission.contacts.status;
    if (status.isGranted) {
      // Permission already granted, navigate to notifications permissions screen
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const ContactsPermissionsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(30, 100, 30, 40),
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
                          builder: (context) => const ContactsPermissionsScreen()));
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xffe94057)),
                ),
              ),
            ),
            const SizedBox(height: 80,),
            Image.asset("assets/permissions/people.png"),
            const SizedBox(height: 60,),
            const Text(
              "Find Nearby People",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            const SizedBox(height: 10,),
            const Text(
              "You can find nearby people to connect and chat with!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black),
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                PermissionStatus status = await Permission.location.request();
                if (status.isGranted) {
                  // Permission granted, navigate to notifications permissions screen
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(builder: (context) => const ContactsPermissionsScreen()),
                  );
                } else {
                  // Handle the case when permission is denied
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Location permission is required!')),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40, 20, 0),
                child: MainButtonDesign(text: "Access Location"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
