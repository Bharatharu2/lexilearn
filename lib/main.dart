import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lexilearn/LetterExercisePage.dart';
import 'package:lexilearn/LetterArrange.dart';
import 'package:lexilearn/AlphabetListeningPage.dart';
import 'package:lexilearn/WordMatchingGame.dart';
import 'package:lexilearn/WordMatchingGame2.dart';
import 'package:lexilearn/RhymeTimeGame.dart';
import 'package:lexilearn/TamilUyirEzhuthukal.dart';
import 'package:lexilearn/TamilUyirEzhuthuKarpom.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductionPage(),
    );
  }
}

class CardOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  CardOption({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 70),
            child: Text(
              "Welcome to LexiLearn",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 600, // Specify the desired height
              width: 400, // Specify the desired width
              child: Padding(
                padding: EdgeInsets.only(
                    top: 10), // Adjust the top padding as needed
                child: Card(
                  elevation: 10,
                  margin: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'images/Disney.jpg', // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text('Get Started'),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What do you want to learn?'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Select what you want to Learn',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CardOption(
                    title: 'English',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnglishPage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10), // Adjust spacing between cards
                  CardOption(
                    title: 'தமிழ்',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TamilPage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10), // Adjust spacing between cards
                  CardOption(
                    title: 'Numbers',
                    onTap: () {
                      // Navigate to Numbers page
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EnglishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Topics'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Section(
              title: 'Letter Exercise',
              onTap: () {
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
              },
            ),
            Section(
              title: 'Alphabet Listening',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlphabetListeningPage(),
                  ),
                );
              },
            ),
            Section(
              title: 'Word Matching Game',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WordMatchingGame(),
                  ),
                );
              },
            ),
            Section(
              title: 'Word Matching Game 2',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WordMatchingGame2(),
                  ),
                );
              },
            ),
            Section(
              title: 'Rhyme Time Game',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RhymeTimeGame(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TamilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tamil Topics'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Section(
              title: 'உயிரெழுத்து கற்போம்',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LetterExercisePage2(),
                  ),
                );
              },
            ),
            Section(
              title: 'உயிரெழுத்து பயிற்சி',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TamilAlphabetListeningPage(),
                  ),
                );
              },
            ),
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
          child: Text(
            title,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
