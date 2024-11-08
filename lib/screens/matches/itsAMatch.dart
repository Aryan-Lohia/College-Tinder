import 'package:college_tinder/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

import '../login/backend.dart';

class ItsAMatch extends StatelessWidget {
  final UserModel matchData;
  const ItsAMatch({Key? key,required this.matchData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Authentication>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,width:250,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Right tilted image (user)
                      Positioned(
                        top:0,right: 0,
                        child: Transform.rotate(
                          angle: 0.2, // Rotate clockwise
                          child: Container(
                            width: 160,
                            height: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image:  DecorationImage(
                                image: NetworkImage(
                                    matchData.profilePicUrl!), // Replace with user image
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),),
                      // Left tilted image (match)
                      Positioned(
                        bottom:0,left: 0,

                        child: Transform.rotate(
                          angle: -0.2, // Rotate counter-clockwise
                          child: Container(
                            width: 160,
                            height: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image:  DecorationImage(
                                image: NetworkImage(
                                    authProvider.userProfile!.profilePicUrl!), // Replace with match image
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                 Text(
                  "It's a match, ${authProvider.userProfile!.firstName!}!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Start a conversation now with each other',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    // Action for starting the conversation
                    Navigator.pop(context);
                  },
                  child:Container(
                    decoration: BoxDecoration(
                        color: Color(0xffe94057),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: Center(
                      child: const Text(
                        'Say Hello',
                        style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // Action for starting the conversation
                    Navigator.pop(context);
                  },
                  child:Container(
                    decoration: BoxDecoration(
                      color: Color(0xffe94057).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: Center(
                      child: const Text(
                        'Keep Swiping',
                        style: TextStyle(fontSize: 18,color: Color(0xffe94057),fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

