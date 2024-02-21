import 'package:http/http.dart' as http;
import 'dart:convert';
import 'assessment_sessions.dart';
import 'package:flutter/material.dart';

Future<void> getToken(String username, String password) async {
  final url = Uri.parse('http://localhost:8000/api/-token/');
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'username': username, 'password': password}),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body)['response']['token']);
  } else {
    throw Exception('Failed to get token.');
  }
}

class AssessmentSessionsProvider with ChangeNotifier {
  AssessmentSessionsProvider() {
    fetchAssessments();
  }

  List<AssessmentSession> _assessmentSessions = [];

  List<AssessmentSession> get assessmentSessions {
    return [..._assessmentSessions];
  }

  fetchAssessments() async {
    var url = Uri.parse("http://localhost:8000/api/assessmentsessions/");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body) as List;
      _assessmentSessions = jsonData
          .map<AssessmentSession>(
              (assessment) => AssessmentSession.fromJson(assessment))
          .toList();
    }
  }
}
