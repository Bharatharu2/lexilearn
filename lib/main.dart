import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:lexilearn/LetterExercisePage.dart';
import 'package:lexilearn/LetterArrange.dart';
import 'package:lexilearn/AlphabetListeningPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LexiLearn',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Section(
              title: 'Letter Exercise',
              onTap: () {
                // Navigate to LetterExercisePage when Letter Exercise section is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LetterExercisePage(),
                  ),
                );
              },
            ),
            Section(
                title: 'LexiPuzzle',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Feature1Page(),
                    ),
                  );
                }),
            Section(
                title: 'AlphabetHarmony',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AlphabetListeningPage()),
                  );
                }),
            Section(title: 'Feature 3'),
            Section(title: 'Feature 4'),
            Section(title: 'Feature 5'),
          ],
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  Section({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Html(
            data:
                '<div style="color: #0077cc; font-size: 18px; font-weight: bold;">$title</div>',
          ),
        ),
      ),
    );
  }
}
