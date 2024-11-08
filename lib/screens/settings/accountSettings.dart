import 'package:college_tinder/screens/settings/changePhoneNumber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool _locationPermission = true;
  bool _notificationPermission = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text('Change Password'),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            ListTile(
              title: Text('Change Phone Number'),
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context)=> ChangePhoneNumberScreen()));

              },
            ),
            ListTile(
              title: Text('Change Email'),
              onTap: () {
                // Navigate to change email screen
              },
            ),
            ListTile(
              title: Text('Link Accounts'),
              onTap: () {
                // Navigate to link accounts screen
              },
            ),
            SizedBox(height: 32.0),
            Text(
              'Permissions',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Location'),
                Switch(
                  value: _locationPermission,
                  onChanged: (value) {
                    setState(() {
                      _locationPermission = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Notifications'),
                Switch(
                  value: _notificationPermission,
                  onChanged: (value) {
                    setState(() {
                      _notificationPermission = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}