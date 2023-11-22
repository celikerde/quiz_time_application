import 'package:flutter/material.dart';
import 'package:quiz_time/screens/home_screen.dart';

void main() {
    runApp(
      MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomeScreen(),
        '/homeScreen': (context) => HomeScreen(),
      },
      ),
    );
}



