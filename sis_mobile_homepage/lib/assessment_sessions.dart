import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sis_mobile_homepage/api.dart';

bool isLoading = false;

class AssessmentList extends StatefulWidget {
  @override
  _AssessmentListState createState() => _AssessmentListState();
}

class _AssessmentListState extends State<AssessmentList> {

  List<dynamic> assessmentList = [];

  fetchAssessments() async {
    final accessToken = await storage.read(key: 'token');
    print(accessToken);
    http.Response response = await http.get(
        Uri.parse("http://localhost:8000/api/assessmentsessions/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Token $accessToken",
        });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("***data*** = $data");
      assessmentList = data["results"]
            .map((item) => AssessmentSession.fromJson(item)).toList();
      return assessmentList;
    } else {
      throw Exception();
    }
  }

  @override
  void initState(){
    _fetchData();
    super.initState();
  }

  Future _fetchData() async{
    setState(() => isLoading = true);
    assessmentList = await fetchAssessments();
    setState(()=> isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    print("**assessmentList**= $assessmentList");
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessments'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: isLoading
        ? CircularProgressIndicator()
        : ListView.builder(
            itemCount: assessmentList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0
              ),
                title: Text(assessmentList[index].title),
                subtitle: Text(assessmentList[index].status)
              );
            }
          )
      )
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