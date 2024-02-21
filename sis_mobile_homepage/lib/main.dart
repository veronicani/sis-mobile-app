import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sis_mobile_homepage/api.dart';
void main() {
  runApp(MyApp());
  // call getToken(username, pw)
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AssessmentSessionsProvider(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromRGBO(228, 107, 102, 1.0)),
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final assessmentSessionsP = Provider.of<AssessmentSessionsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessments'),
      ),
      body: ListView.builder(
        itemCount: assessmentSessionsP.assessmentSessions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(assessmentSessionsP.assessmentSessions[index].title),
            );
        },
      ),
    );
  }
}