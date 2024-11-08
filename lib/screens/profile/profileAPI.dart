import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/UserModel.dart';
import '../../secrets.dart';

class ProfileController{

  Future<void> updateProfile(UserModel userData) async {

  }


    Future<bool> checkIfMatch(int user1,int user2) async {

    final url = '${Secret.BASE_URL}/matches/checkIfExists'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      "userId1":user1,
      "userId2":user2,
    });
    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['match'];
      } else {
        Fluttertoast.showToast(
          msg: "Check your internet and try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print('Failed to submit data: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return false;
  }

}