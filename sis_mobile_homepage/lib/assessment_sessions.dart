import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sis_mobile_homepage/api.dart';


class AssessmentList extends StatefulWidget {
  @override
  _AssessmentListState createState() => _AssessmentListState();
}

class _AssessmentListState extends State<AssessmentList> {

  List<dynamic> assessmentList = [];

  void fetchAssessments() async {
    final accessToken = await storage.read(key: 'token');
    final response = await http.post(
        Uri.parse("http://localhost:8000/api/assessmentsessions/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Token $accessToken",
        });
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState((){
        for (var value in data){
          assessmentList.add(value);
          print(assessmentList);
        }
      });
    }
  }

  @override
  void initState(){
    fetchAssessments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessments'),
      ),
      body: ListView(
        children: <Widget>[
          ListView.builder(
            itemCount: assessmentList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(assessmentList[index].title),
              );
            },
          ),
        ],
      ),
    );
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
