import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.openDyslexic(),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpenDyslexic Font Example'),
      ),
      body: Center(
        child: Text(
          'This is an example of OpenDyslexic font.',
          style: GoogleFonts.openDyslexic(fontSize: 24),
        ),
      ),
    );
  }
}
