import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class RhymeTimeGame extends StatefulWidget {
  @override
  _RhymeTimeGameState createState() => _RhymeTimeGameState();
}

class _RhymeTimeGameState extends State<RhymeTimeGame> {
  final AudioPlayer player = AudioPlayer();
  List<String> words = [
    'king', 'ring', 'table', 'cable', 'blossom', 'awesome', 'broom', 'groom',
    // Add more words here...
  ];
  Map<String, String> rhymePairs = {
    'king': 'ring',
    'ring': 'king',
    'table': 'cable',
    'cable': 'table',
    'blossom': 'awesome',
    'awesome': 'blossom',
    'broom': 'groom',
    'groom': 'broom',
    // Add more pairs here...
  };
  String selectedWord = '';
  String correctOption = '';
  List<String> rhymeOptions = [];
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    _setNextQuestion();
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  void _setNextQuestion() {
    setState(() {
      selectedWord = words[Random().nextInt(words.length)];
      correctOption = rhymePairs[selectedWord] ?? '';

      // Generate incorrect options
      rhymeOptions = [];
      while (rhymeOptions.length < 3) {
        String randomWord = words[Random().nextInt(words.length)];
        if (randomWord != selectedWord &&
            randomWord != correctOption &&
            !rhymeOptions.contains(randomWord)) {
          rhymeOptions.add(randomWord);
        }
      }

      // Add correct option to the list
      rhymeOptions.add(correctOption);
      rhymeOptions.shuffle();

      isCorrect = false; // Reset correctness flag
    });
  }

  void checkMatch(String word) {
    setState(() {
      isCorrect = word == correctOption;
    });
    if (isCorrect) {
      playSound("audio/yay.mp3");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Correct Match!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "images/Monkey2.gif",
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
      );
    } else {
      playSound("audio/wrong.mp3");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Wrong Match!'),
          content: Image.asset(
            "images/tomwrong.gif",
            width: 100,
            height: 100,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rhyme Time'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedWord.toUpperCase(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(rhymeOptions.length, (index) {
                String word = rhymeOptions[index];
                return GestureDetector(
                  onTap: () {
                    if (!isCorrect) {
                      checkMatch(word);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        word.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _setNextQuestion();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
