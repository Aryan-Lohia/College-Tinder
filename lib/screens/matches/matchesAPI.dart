import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../secrets.dart';


class MatchesController{

  Future getMatchesList(int id) async {
    final url = '${Secret
        .BASE_URL}/matches/get/${id.toString()}'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(Uri.parse(url),
          headers: headers,);

      if (response.statusCode == 200) {
        // Handle successful response
        print(response.body);
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
Future removeMatches(int userId,int matchId) async {
    final url = '${Secret
        .BASE_URL}/matches/remove'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};
    final body =jsonEncode({
      'userId':userId,
      'matchId':matchId
    });
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers,body: body);

      if (response.statusCode == 200) {
        // Handle successful response
        print(response.body);
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

}