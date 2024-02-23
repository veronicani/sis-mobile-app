import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///Rithm SIS API.
const baseApiUrl = 'http://localhost:8000/api';
final storage = FlutterSecureStorage();

/// getToken: Sends user credentials to retrieve token and store in local
/// storage for future API requests.
///   Inputs: username, password
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

/// fetchAssessmentUrls: Fetches all assessment session urls from SIS API.
///  Returns: [api_url, ...]
fetchAssessmentUrls() async {
    final token = await storage.read(key: 'token');

    http.Response response = await http.get(
        Uri.parse("$baseApiUrl/assessmentsessions/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Token $token",
        });

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['results'];
      List urls = data.map((item) => (item['api_url'])).toList();
      return urls;
    } else {
      throw Exception('Failed to fetch assessment session urls.');
    }
}

/// fetchAssessmentDetail: Fetches details for one assessment session.
///   Inputs: url - assessmentsession api_url
///   Returns: { id, assessment, title, cohort, description, dri, week_group,
///     start_at, end_at, require_github_url, require_deployment_url, 
///     require_zipfile, is_pass_fail, submission_set }
fetchAssessmentDetail(url) async {
  final token = await storage.read(key: 'token');

  http.Response response = await http.get(
    Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Token $token",
        });
  if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch assessment session detail.');
    }
}
