import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();

Future<AssessmentSession> fetchAssessments() async {
  final accessToken = await storage.read(key: 'token');
  final response = await http.post(
      Uri.parse("http://localhost:8000/api/assessmentsessions/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $accessToken",
      });
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body) as List;
    print(response.body);
    _assessmentSessions = jsonData
        .map<AssessmentSession>(
            (assessment) => AssessmentSession.fromJson(assessment))
        .toList();
  }
}

class AssessmentSession {
  final int id;
  final String title;
  final String status;
  final String apiUrl;

  const AssessmentSession(
    {
      required this.id,
      required this.title,
      required this.status,
      required this.apiUrl
    });

  factory AssessmentSession.fromJson(Map<String, dynamic> json){
    return AssessmentSession(
      id: json["id"],
      title: json["title"],
      status: json["status"],
      apiUrl: json["api_url"],
    );
  }
}
