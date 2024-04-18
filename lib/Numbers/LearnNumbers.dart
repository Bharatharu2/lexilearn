import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NumberLearningPage(),
    );
  }
}

class NumberLearningPage extends StatefulWidget {
  @override
  _LetterExercisePageState createState() => _LetterExercisePageState();
}

class _LetterExercisePageState extends State<NumberLearningPage> {
  int currentIndex = 0;
  AudioPlayer player = AudioPlayer();

  List<LetterInfo> letterInfoList = [
    LetterInfo(letter: '0', image: 'Zero.png', lettersound: 'audio/zero.mp3'),
    LetterInfo(letter: '1', image: 'one.jpg', lettersound: 'audio/one.mp3'),
    LetterInfo(letter: '2', image: 'two.jpg', lettersound: 'audio/two.mp3'),
    LetterInfo(letter: '3', image: 'three.jpg', lettersound: 'audio/three.mp3'),
    LetterInfo(letter: '4', image: 'four.webp', lettersound: 'audio/four.mp3'),
    LetterInfo(letter: '5', image: 'five.jpg', lettersound: 'audio/five.mp3'),
    LetterInfo(letter: '6', image: 'six.jpg', lettersound: 'audio/six.mp3'),
    LetterInfo(letter: '7', image: 'seven.png', lettersound: 'audio/seven.mp3'),
    LetterInfo(letter: '8', image: 'eight.jpg', lettersound: 'audio/eight.mp3'),
    LetterInfo(letter: '9', image: 'nine.jpg', lettersound: 'audio/nine.mp3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Learn Numbers'),
      ),
      body: PageView.builder(
        itemCount: letterInfoList.length,
        controller: PageController(initialPage: currentIndex),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      letterInfoList[index].letter,
                      style: TextStyle(
                        fontSize: 48,
                        fontFamily: 'openDyslexic',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'images/${letterInfoList[index].image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    playSound(letterInfoList[index].lettersound);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Listen Letter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }
}

class LetterInfo {
  final String letter;
  final String image;
  final String lettersound;

  LetterInfo({
    required this.letter,
    required this.image,
    required this.lettersound,
  });
}
