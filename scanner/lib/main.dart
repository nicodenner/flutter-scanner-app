import 'package:flutter/material.dart';
import 'package:scanner/home_screen.dart' as home_screen;

void main() {
  runApp(ScannerApp());
}

class ScannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home_screen.ScannerHomeScreen(),
      color: Colors.teal,
    );
  }
}

