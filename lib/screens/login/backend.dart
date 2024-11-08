import 'dart:convert';
import 'package:college_tinder/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../secrets.dart';

class Authentication extends ChangeNotifier {
  Map? userRegistered;
  User? currentUser;
  UserModel? userProfile;
  UserCredential? credential;
  Authentication() {
    _authStateListener(); // Initialize the auth state listener when the class is instantiated
  }
  // Function to listen to FirebaseAuth state changes
  void _authStateListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      currentUser = user; // Update currentUser with the new user state
      if (currentUser != null) {
        if (await checkIfUserExists(currentUser!.uid)) {
          await getUserDetails(currentUser!.uid);
          userRegistered = {"created": false, 'exists': true};

        } else {
          if (await registerUser(
              currentUser!.uid, currentUser!.phoneNumber, currentUser!.email)) {
            await getUserDetails(currentUser!.uid);
            userRegistered = {"created": true, 'exists': false};
          } else {
            userRegistered = {"created": false, 'exists': false};
          }
        }
      }
      notifyListeners(); // Notify listeners about the change
    });
  }

  Future<void> processCredentials(UserCredential userCredential) async {
    try {
      credential = userCredential;
      // if (await checkIfUserExists(userCredential.user!.uid)) {
      //   userRegistered= {"created": false, 'exists': true};
      // }
      // else {
      //   print("User does not Already Exists");
      //   if(await registerUser(userCredential.user!.uid, userCredential.user!.phoneNumber, userCredential.user!.email))
      //   {
      //     userRegistered= {"created": true, 'exists': false};
      //   }
      //   else{
      //     userRegistered= {"created": false, 'exists': false};
      //   }
      // }
      // Handle successful response
    } catch (error) {
      print('Error: $error');
    }
    notifyListeners();
  }

  Future<bool> registerUser(String authID, String? phone, String? email) async {
    final url1 =
        '${Secret.BASE_URL}/users/register'; // Replace with your API endpoint
    final headers1 = {'Content-Type': 'application/json'};

    final body1 = jsonEncode({
      'auth_id': authID,
      'phone': phone,
      'email': email,
    });
    try {
      final response =
          await http.post(Uri.parse(url1), headers: headers1, body: body1);

      if (response.statusCode == 200) {
        // Handle successful response
        return true;
      } else {
        // Handle error response
        print('Failed to submit data: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  Future<bool> checkIfUserExists(String authID) async {
    final url =
        '${Secret.BASE_URL}/users/checkIfUserExists'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'auth_id': authID,
    });
    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['exists']) {
          return true;
        } else {
          return false;
        }
        // Handle successful response
      } else {
        // Handle error response
        print('Failed to submit data: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  Future<void> getUserDetails(String authID) async {
    final url =
        '${Secret.BASE_URL}/users/getUserProfile'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'auth_id': authID,
    });
    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic>? tempUserProfile =jsonDecode(response.body);
        if (tempUserProfile != null) {
          userProfile = UserModel.fromJson(tempUserProfile);
        }
      }
      // Handle successful response
      else {
        // Handle error response
        print('Failed to submit data: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
    notifyListeners();
  }
}
