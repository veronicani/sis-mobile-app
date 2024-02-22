import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///SIS API.
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
///  Returns: [{id, title, status, api_url}, ...]

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

/// fetchAssessmentDetail: Fetches details for one assessment session.
///   Inputs: id - assessmentsession id (int)
///   Returns: { id, assessment, title, cohort, description, dri, week_group,
///     start_at, end_at }
///   TODO: docstring doesn't match (couldn't destructure)

fetchAssessmentDetail(id) async {
  final token = await storage.read(key: 'token');

  http.Response response = await http.get(
    Uri.parse("$baseApiUrl/assessmentsessions/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Token $token",
        });
  if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      print('fetchAssessmentDetail data= $data');
      return data;
      // if (data
      //     case {
      //       'id': int id,
      //       'title': String title,
      //       'description': String description,
      //       'dri': String dri,
      //       'start_at': DateTime startAt,
      //       'end_at': DateTime endAt,
      //       'asset_set': List assetSet
      //     }) {
      //       var parsedOut = (id, title, description, dri, startAt, endAt, assetSet);
      //       print("parsedOut= $parsedOut");
      //       return parsedOut;
      //     } else {
      //       throw const FormatException('Unexpected JSON');
      //     }
        } else {
      throw Exception('Failed to fetch assessment session detail.');
    }
}
