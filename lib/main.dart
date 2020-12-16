import 'splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme:
          ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}
