import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const baseApiUrl = 'http://localhost:8000/api'; 
final storage = FlutterSecureStorage();

/// getToken: Sends user credentials to retrieve token and store in local 
/// storage for future API requests.

Future<void> getToken(String username, String password) async {
  final url = Uri.parse('$baseApiUrl/-token/');
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'username': username, 'password': password}),
  );
  if (response.statusCode == 200) {
    String token = json.decode(response.body)['token'];
    await storage.write(key: 'token', value: token);
  } else {
    throw Exception('Failed to get token.');
  }
}

/// fetchAssessments: Fetches all assessment session data from SIS API.

fetchAssessments() async {
    final token = await storage.read(key: 'token');
  
    http.Response response = await http.get(
        Uri.parse("$baseApiUrl/assessmentsessions/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Token $token",
        });

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['results'];
      return data;
    } else {
      throw Exception('Failed to fetch assessment sessions.');
    }
}