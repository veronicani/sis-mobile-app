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

  Future loadAssessments() async {
    setState(() => isLoading = true);

    List urls = await sis_api.fetchAssessmentUrls();
    //FIXME: need to await fetch calls
    List data = urls
      .map((url) => sis_api.fetchAssessmentDetail(url)).toList();
    print('data=$data');
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
        title: Text('Assessments'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: isLoading
        ? CircularProgressIndicator()
        : Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth> {
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            children: List<TableRow>.generate(
              assessmentList.length,
              (index) {
                final assessment = assessmentList[index];
                return TableRow(
                  children: [
                    Padding(padding: EdgeInsets.all(5.0),
                    child: Text(assessment.title, textAlign: TextAlign.center),
                    ),
                    Padding(padding: EdgeInsets.all(5.0),
                    child: Text(assessment.status, textAlign: TextAlign.center)
                    ),
                  ]
                );
              },
              growable:false,
            ),
          ),
              // return ListTile(
              //   contentPadding: EdgeInsets.symmetric(
              //   horizontal: 10.0,
              //   vertical: 10.0
              // ),
              //   title: Text(assessmentList[index].title),
              //   subtitle: Text(assessmentList[index].status)
              // );
          )
      );
  }
}