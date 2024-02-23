import 'package:flutter/material.dart';

import 'package:sis_mobile_homepage/assessment_sessions.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

/// Main app.

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

/// State for main app.

class MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rithm App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromRGBO(228, 107, 102, 1.0)
          ),
          textTheme: TextTheme(
            displayLarge: GoogleFonts.sourceSerif4(
              fontSize: 30,
            ),
            bodyMedium: GoogleFonts.sourceSerif4(
              fontSize: 16,
            )
        ),
        ),
        home: AssessmentList(),
      );
  }
}