import 'package:college_tinder/common/components/buttonDesign.dart';
import 'package:college_tinder/screens/login/phoneSignupScreen.dart';
import 'package:college_tinder/screens/login/providers/google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import 'backend.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final authWrapper = Provider.of<Authentication>(context); // Listen to changes in authProvider
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30, 50, 30, 40),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset("assets/logo.png"),
            const Text(
              "College Hearts",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
            SizedBox(
              height: 50,
            ),
            const Text(
              "Sign Up To Continue",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 40, 30, 30),
              child: InkWell(
                onTap: () {},
                child: MainButtonDesign(text: "Continue with email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 60),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>const PhoneSignupScreen()));

                },
                child: SecondaryButtonDesign(text: "Use Phone number"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Flexible(child: Divider(thickness: 0.3,color: Colors.black,height: 1,)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "or sign up with",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.black),
                    ),
                  ),
                  Flexible(child: Divider(thickness: 0.3,color: Colors.black,height: 1,)),

                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){},
                    child: Image.asset("assets/signup/Facebook.png"),
                  ),InkWell(
                    onTap: ()async{
                      UserCredential? credential=await signInWithGoogle();
                      if (credential != null) {
                        await authWrapper.processCredentials(credential);
                      }
                    },
                    child: Image.asset("assets/signup/Google.png"),
                  ),InkWell(
                    onTap: (){},
                    child: Image.asset("assets/signup/Apple.png"),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){},
                    child: TextButton(onPressed: (){}, child: Text("Terms of use",style: TextStyle(color: Color(0xffe94057)),)),
                  ),InkWell(
                    onTap: (){},
                    child: TextButton(onPressed: (){}, child: Text("Privacy Policy",style: TextStyle(color: Color(0xffe94057)),)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
