import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class WordMatchingGame extends StatefulWidget {
  @override
  _WordMatchingGameState createState() => _WordMatchingGameState();
}

class _WordMatchingGameState extends State<WordMatchingGame> {
  final AudioPlayer player = AudioPlayer();
  List<String> words = [
    'apple',
    'backpack',
    'candle',
    'desk',
    'earphones',
    'flower',
    'glasses',
    'hat',
    'ice cream',
    'jacket',
    'kettle',
    'lamp',
    'mug',
    'notebook',
    'orange',
    'pillow',
    'quilt',
    'ring',
    'scissors',
    'television',
    'umbrella',
    'vase',
    'wallet',
    'xerox machine',
    'yogurt',
    'zipper',
    'banana',
    'chair',
    'door',
    'fan',
    'grapes',
    'helmet',
    'iron',
    'jeans',
    'knife',
    'lemon',
    'mirror',
    'nail',
    'oven',
    'pen',
    'queue',
    'refrigerator',
    'spoon',
    'table',
    'usb',
    'vehicle',
    'watch',
    'xylophone',
    'yacht',
    'zebra crossing',
    'alarm clock',
    'broom',
    'computer',
    'dishwasher',
    'eraser',
    'frying pan',
    'guitar',
    'hammer',
    'ice tray',
    'jug',
    'key',
    'light bulb',
    'mouse',
    'note',
    'piano',
    'quiver',
    'roller',
    'sandwich',
    'toaster',
    'umbrella stand',
    'violin',
    'window',
    'yak',
    'zucchini'
  ];
  List<String> shuffledWords = [];
  List<String> images = [
    'apple.png',
    'backpack.png',
    'candle.png',
    'desk.png',
    'earphones.png',
    'flower.png',
    'glasses.png',
    'hat.png',
    'ice cream.png',
    'jacket.png',
    'kettle.png',
    'lamp.png',
    'mug.png',
    'notebook.png',
    'orange.png',
    'pillow.png',
    'quilt.png',
    'ring.png',
    'scissors.png',
    'television.png',
    'umbrella.png',
    'vase.png',
    'wallet.png',
    'xerox machine.png',
    'yogurt.png',
    'zipper.png',
    'banana.png',
    'chair.png',
    'door.png',
    'fan.png',
    'grapes.png',
    'helmet.png',
    'iron.png',
    'jeans.png',
    'knife.png',
    'lemon.png',
    'mirror.png',
    'nail.png',
    'oven.png',
    'pen.png',
    'queue.png',
    'refrigerator.png',
    'spoon.png',
    'table.png',
    'usb.png',
    'vehicle.png',
    'watch.png',
    'xylophone.png',
    'yacht.png',
    'zebra crossing.png',
    'alarm clock.png',
    'broom.png',
    'computer.png',
    'dishwasher.png',
    'eraser.png',
    'frying pan.png',
    'guitar.png',
    'hammer.png',
    'ice tray.png',
    'jug.png',
    'key.png',
    'light bulb.png',
    'mouse.png',
    'note.png',
    'piano.png',
    'quiver.png',
    'roller.png',
    'sandwich.png',
    'toaster.png',
    'umbrella stand.png',
    'violin.png',
    'window.png',
    'yak.png',
    'zucchini.png'
  ];
  String selectedWord = '';
  String selectedImage = '';
  List<String> answerOptions = [];
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
      shuffledWords = List.from(words);
      shuffledWords.shuffle();
      selectedWord = shuffledWords[0];
      selectedImage = images[words.indexOf(selectedWord)];

      answerOptions.clear();
      answerOptions.add(selectedWord);

      // Add two random incorrect answers
      Random random = Random();
      while (answerOptions.length < 3) {
        String randomWord = words[random.nextInt(words.length)];
        if (!answerOptions.contains(randomWord)) {
          answerOptions.add(randomWord);
        }
      }

      answerOptions.shuffle();
      isCorrect = false; // Reset correctness flag
    });
  }

  void checkMatch(String word) {
    setState(() {
      isCorrect = word == selectedWord;
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
                "images/thumbsup.gif",
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
        title: Text('Word Matching Game'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose the correct word!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                checkMatch(selectedWord);
              },
              child: Image.asset(
                "images2/$selectedImage",
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: answerOptions.map((word) {
                return GestureDetector(
                  onTap: () {
                    if (!isCorrect) {
                      checkMatch(word);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isCorrect && word == selectedWord
                          ? Colors.green
                          : Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      word.toUpperCase(),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _setNextQuestion();
              },
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
