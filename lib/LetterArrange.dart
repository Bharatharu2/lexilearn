import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

class Feature1Page extends StatefulWidget {
  @override
  _Feature1PageState createState() => _Feature1PageState();
}

class _Feature1PageState extends State<Feature1Page> {
  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer player = AudioPlayer();
  List<String> words = [];
  List<String> jumbledWord = [];
  String currentWord = '';
  String userAnswer = '';
  bool isCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    generateWords();
    getRandomWord();
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  void generateWords() {
    words = [
      'lamp',
      'table',
      'chair',
      'train',
      'water',
      'phone',
      'mouse',
      'clock',
      'piano',
      'snake',
      'heart'
    ];
  }

  void getRandomWord() {
    Random random = Random();
    int index = random.nextInt(words.length);
    setState(() {
      currentWord = words[index];
      jumbledWord = _jumbleWord(currentWord.split(''));
      isCorrectAnswer = false;
    });
  }

  List<String> _jumbleWord(List<String> word) {
    List<String> jumbled = List.from(word);
    jumbled.shuffle();
    return jumbled;
  }

  void checkAnswer() {
    setState(() {
      isCorrectAnswer = userAnswer == currentWord;
    });
    if (isCorrectAnswer) {
      playSound("audio/yay.mp3");
    } else {
      playSound("audio/wrong.mp3");
    }
  }

  void speakCurrentWord() async {
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.speak(currentWord);
  }

  void swapLetters(int draggedIndex, int targetIndex) {
    setState(() {
      String temp = jumbledWord[draggedIndex];
      jumbledWord[draggedIndex] = jumbledWord[targetIndex];
      jumbledWord[targetIndex] = temp;
      // Update userAnswer based on the new arrangement
      userAnswer = jumbledWord.join();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LexiPuzzle',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Text(
                'Listen to the word:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: speakCurrentWord,
                    child: Text('Speak', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Make it fully round
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: getRandomWord,
                    child:
                        Text('Refresh', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Make it fully round
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: Image.asset(
                            "images/${currentWord.toLowerCase()}.png",
                            width: 200,
                            height: 200,
                          ),
                        ),
                      );
                    },
                    child: Text('Hint', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Make it fully round
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Arrange the letters:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: List.generate(jumbledWord.length, (index) {
                  String char = jumbledWord[index];
                  return Draggable<String>(
                    data: char,
                    feedback: Material(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.circular(10), // Square shape
                        ),
                        child: Text(
                          char,
                          style: TextStyle(
                              fontSize: 50,
                              color:
                                  Colors.white), // Set a consistent font size
                          textAlign: TextAlign.center, // Center the text
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10), // Square shape
                      ),
                      child: Text(
                        '',
                        style: TextStyle(
                            fontSize: 30), // Set a consistent font size
                      ),
                    ),
                    child: DragTarget<String>(
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(10), // Square shape
                          ),
                          child: Text(
                            char,
                            style: TextStyle(
                                fontSize: 30,
                                color:
                                    Colors.white), // Set a consistent font size
                            textAlign: TextAlign.center, // Center the text
                          ),
                        );
                      },
                      onWillAccept: (data) => true,
                      onAccept: (data) {
                        int draggedIndex = jumbledWord.indexOf(data);
                        int targetIndex = jumbledWord.indexOf(char);
                        List<String> temp = List.from(jumbledWord);
                        temp[draggedIndex] = jumbledWord[targetIndex];
                        temp[targetIndex] = jumbledWord[draggedIndex];
                        setState(() {
                          jumbledWord = temp;
                          userAnswer = jumbledWord.join();
                        });
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: 35),
              ElevatedButton(
                onPressed: () {
                  checkAnswer();
                  if (isCorrectAnswer) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Correct Answer!'),
                        content: Image.asset(
                          "images/Monkey2.gif",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Wrong Answer!'),
                        content: Image.asset(
                          "images/thumbsDown.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(50), // Make it fully round
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
