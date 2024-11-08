import 'package:flutter/material.dart';

class HelpAndSupport extends StatefulWidget {
  @override
  _HelpAndSupportState createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  final List<String> _faqQuestions = [
    'How do I change my profile picture?',
    'How do I update my personal information?',
    'What do I do if I encounter a bug or issue?',
    'How do I get in touch with customer support?',
  ];

  final List<String> _faqAnswers = [
    'To change your profile picture, go to the "Account Settings" section and click on the "Profile Picture" option.',
    'To update your personal information, go to the "Account Settings" section and make the necessary changes.',
    'If you encounter a bug or issue, please report it to our customer support team by emailing us at support@collegetinder.com.',
    'You can get in touch with our customer support team by emailing us at support@collegetinder.com or by calling our toll-free number at 1-800-123-4567.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help and Support'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAQ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.separated(
                itemCount: _faqQuestions.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(_faqQuestions[index]),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(_faqAnswers[index]),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Email: support@collegetinder.com',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Phone: 1-800-123-4567',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}