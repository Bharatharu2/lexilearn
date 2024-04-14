import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class WordMatchingGame2 extends StatefulWidget {
  @override
  _WordMatchingGameState createState() => _WordMatchingGameState();
}

class _WordMatchingGameState extends State<WordMatchingGame2> {
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
    'yatch',
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
    'umbrella stand',
    'violin',
    'window',
    'yak',
    'zucchini'
  ];
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
    'yatch.png',
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
    'umbrella stand.png',
    'violin.png',
    'window.png',
    'yak.png',
    'zucchini.png'
  ];
  String selectedWord = '';
  String selectedImage = '';
  List<String> displayedImages = [];
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
      Random random = Random();
      int index = random.nextInt(words.length);
      selectedWord = words[index];
      selectedImage = images[index];

      displayedImages.clear();
      displayedImages.add(selectedImage);

      while (displayedImages.length < 4) {
        String randomImage = images[random.nextInt(images.length)];
        if (!displayedImages.contains(randomImage)) {
          displayedImages.add(randomImage);
        }
      }

      displayedImages.shuffle();
      isCorrect = false;
    });
  }

  void checkMatch(String image) {
    setState(() {
      isCorrect = image == selectedImage;
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
                "images/Monkey2.gif", // Replace with your correct image path
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "images/thumbsDown.png", // Replace with your wrong image path
                width: 100,
                height: 100,
              ),
            ],
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
              selectedWord.toUpperCase(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(displayedImages.length, (index) {
                String image = displayedImages[index];
                return GestureDetector(
                  onTap: () {
                    if (!isCorrect) {
                      checkMatch(image);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Image.asset(
                      "images2/$image",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
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
              child: Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
