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

  /// loadAssessments: Makes call to API for assessments sessions, and updates
  /// assessmentList with list of jsonified assessment sessions objects.
  /// Updates isLoading state.

  Future<List> fetchAllAssessmentDetail(urls) async {

    List finalData = [];

    // await Future.wait(urls.forEach((url) async {
    //     var data = await sis_api.fetchAssessmentDetail(url);
    //     finalData.add(data);
    //   }));

    for (var url in urls) {
        var data = await sis_api.fetchAssessmentDetail(url);
        finalData.add(data);
    }

    return finalData;
  }

  Future loadAssessments() async {
    setState(() => isLoading = true);

    List urls = await sis_api.fetchAssessmentUrls();
    List data = await fetchAllAssessmentDetail(urls);

    assessmentList = data
                .map((item) => AssessmentSession.fromJson(item)).toList();
    print('assessmentList=$assessmentList');
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
        title: Text('{R} Rithm'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Assessment',
                      style: Theme.of(context).textTheme.displayLarge),
                Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        Text('Assessment',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Status',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                      for (var assessment in assessmentList)
                        TableRow(children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child:
                                Text(assessment.title, textAlign: TextAlign.center),
                          ),
                          Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text(assessment.startAt,
                                      textAlign: TextAlign.center),
                                  Text(assessment.endAt,
                                      textAlign: TextAlign.center)
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

