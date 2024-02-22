import 'package:flutter/material.dart';

import 'package:sis_mobile_homepage/api.dart' as sis_api;


/// AssessmentList widget.

class AssessmentList extends StatefulWidget {
  @override
  AssessmentListState createState() => AssessmentListState();
}

/// AssessmentListState: manages state for AssessmentList widget.

class AssessmentListState extends State<AssessmentList> {
  bool isLoading = false;
  List assessmentList = [];

  /// loadAssessments: Makes call to API for assessments sessions, and updates 
  /// assessmentList with list of jsonified assessment sessions objects.
  /// Updates isLoading state.
  
  Future loadAssessments() async {
    setState(() => isLoading = true);
    
    List data = await sis_api.fetchAssessments();
    print('data=$data');
    assessmentList = data
              .map((item) => AssessmentSession.fromJson(item)).toList();
    
    setState(()=> isLoading = false);
  }
  
  /// initState: initializes state and fetches API data on widget load.
  
  @override
  void initState(){
    loadAssessments();
    super.initState();
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

//TODO: move somewhere else? if so, need to import the file here to use fromJson

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