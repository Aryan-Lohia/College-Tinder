import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class PhoneAuthentication extends ChangeNotifier {
  String? otp;
  String? verificationID;
  int? resendCode;
  bool hideOTP = true;
  bool remember = true;
  bool otpGenerated = false;
  bool otpSubmitted = false;
  String? areaCode;
  String? phone;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthCredential?> linkPhoneNumber(String phone, {int? resendCode}) async {
    AuthCredential? credentials;
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      forceResendingToken: resendCode,
      verificationCompleted: (PhoneAuthCredential credential) async {
        credentials = credential;
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        otpGenerated = true;
        this.resendCode = resendToken;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    return credentials;
  }

  Future<UserCredential> signIn(AuthCredential credential) async {
    return await _auth.signInWithCredential(credential);
  }

  Future<UserCredential?> verifyPhoneNumber(String phone, {int? resendCode}) async {
    UserCredential? userCredential;

    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      forceResendingToken: resendCode,
      verificationCompleted: (PhoneAuthCredential credential) async {
        userCredential = await signIn(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        otpGenerated = true;
        this.resendCode = resendToken;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    return userCredential;
  }

  Future<UserCredential> verifyOTP(String code, String verificationId) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    );

    return signIn(credential);
  }


  Future<UserCredential?> signInWithFacebook() async {
    // Trigger the Facebook Sign-In flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) {
      return null; // User canceled the sign-in
    }

    // Create a credential from the Facebook access token
    final OAuthCredential facebookCredential = FacebookAuthProvider.credential(
      loginResult.accessToken!.tokenString,
    );

    // Once signed in, return the UserCredential
    return signIn(facebookCredential);
  }

  Future<bool> checkIfUserExists(String? phone, String? email) async {
    final url = 'https://your-node-api-endpoint.com/check-user'; // Replace with your Node API URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String?>{
          'phone': phone,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Assuming the response contains a field `exists` that tells if the user exists
        return data['exists'] ?? false;
      } else {
        // Handle the error based on status code or response body
        print('Failed to check user existence. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error occurred while checking user existence: $e');
      return false;
    }
  }
}
