import 'package:flutter/material.dart';

import 'package:sis_mobile_homepage/api.dart' as sis_api;
import 'package:sis_mobile_homepage/models/assessment_session.dart';

/// AssessmentList widget.
class AssessmentList extends StatefulWidget {
  @override
  AssessmentListState createState() => AssessmentListState();
}

/// AssessmentListState: manages state for AssessmentList widget.
class AssessmentListState extends State<AssessmentList> {
  bool isLoading = false;
  List assessmentList = [];

  /// fetchAllAssessmentDetail: Given a list of api urls for assessment sessions,
  /// makes requests for assessment session details.
  ///   Returns a list of assessment session objects.
  Future<List> fetchAllAssessmentDetail(urls) async {
    List finalData = [];

    for (var url in urls) {
        var data = await sis_api.fetchAssessmentDetail(url);
        finalData.add(data);
    }

    return finalData;
  }
  
  /// loadAssessments: Makes call to API for assessments sessions, and updates
  /// assessmentList with list of jsonified assessment session objects.
  /// Updates isLoading state.
  Future loadAssessments() async {
    setState(() => isLoading = true);

    List urls = await sis_api.fetchAssessmentUrls();
    List data = await fetchAllAssessmentDetail(urls);

    assessmentList =
        data.map((item) => AssessmentSession.fromJson(item)).toList();
    
    setState(() => isLoading = false);
  }

  /// initState: initializes state and fetches API data on widget load.
  @override
  void initState(){
    loadAssessments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('{R} Rithm Upcoming'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Assessments',
                      style: Theme.of(context).textTheme.displayLarge),
                Table(
                    border: TableBorder(horizontalInside:
                    BorderSide(width: 1, color: Colors.black26, style:
                    BorderStyle.solid)),
                    children: [
                      TableRow(children: [
                        Text('Assessment',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Status',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                      for (var assessment in assessmentList)
                        TableRow(children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child:
                                Text(assessment.title,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[900])),
                          ),
                          Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Open at: ${assessment.startAt}',
                                      textAlign: TextAlign.left),
                                  Text('Close at: ${assessment.endAt}',
                                      textAlign: TextAlign.left)
                                ],
                              )),
                        ]),
                    ],
                  ),
              ],
            ),
      ),
    ),
    );
  }
}

