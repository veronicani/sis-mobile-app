import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sis_mobile_homepage/api.dart';
import 'package:sis_mobile_homepage/assessment_sessions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromRGBO(228, 107, 102, 1.0)),
        ),
        home: AssessmentList(),
      );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context){
//     final assessmentSessionsP = Provider.of<AssessmentSessionsProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Assessments'),
//       ),
//       body: ListView.builder(
//         itemCount: assessmentSessionsP.assessmentSessions.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(assessmentSessionsP.assessmentSessions[index].title),
//             );
//         },
//       ),
//     );
//   }
// }