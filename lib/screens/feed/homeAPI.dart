import 'dart:convert';
import 'package:college_tinder/common/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../secrets.dart';
import '../login/backend.dart';

class HomeController{

  Future<Map?> getUsersList(int id,Map<String,dynamic> filters) async {
    final url = '${Secret
        .BASE_URL}/home/'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'id':id,
      'preferredGender': filters['interestedIn'],
      'minAge': (filters['ageRange'] as RangeValues).start,
      'maxAge':(filters['ageRange'] as RangeValues).end,
      'distance': filters['distance'],
      'location': filters['location']
    });
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: body);

      if (response.statusCode == 200) {
        // Handle successful response
        return jsonDecode(response.body);
      } else {
        // Handle error response
        print('Failed to submit data: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

Future<bool?> swipe(int swiperID,int swipeeID,swiperAction action) async {
    final url = '${Secret
        .BASE_URL}/swipes/swipe'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'swiperId': swiperID,
      'swipeeId': swipeeID,
      'isRightSwipe':action==swiperAction.like,
    });
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: body);

      if (response.statusCode == 200) {
        // Handle successful response
        print(jsonDecode(response.body));
         return jsonDecode(response.body)['match'];
      } else {
        // Handle error response
        print('Failed to submit data: ${response.body}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }
}