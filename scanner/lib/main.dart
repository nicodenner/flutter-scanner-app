import 'package:flutter/material.dart';
import 'package:scanner/home_screen.dart';

void main() {
  runApp(ScannerApp());
}

class ScannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      color: Colors.teal,
    );
  }
}

