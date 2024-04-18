import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class NumberExercise extends StatefulWidget {
  @override
  _NumberExerciseState createState() => _NumberExerciseState();
}

class _NumberExerciseState extends State<NumberExercise> {
  final AudioPlayer player = AudioPlayer();
  String currentNumber = '';
  String selectedNumber = '';
  bool isCorrectAnswer = false;
  bool isFirstTime = true;
  bool isListenButtonPressed = false;

  List<String> numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  Map<String, String> numberAudios = {
    '0': 'audio/zero.mp3',
    '1': 'audio/one.mp3',
    '2': 'audio/two.mp3',
    '3': 'audio/three.mp3',
    '4': 'audio/four.mp3',
    '5': 'audio/five.mp3',
    '6': 'audio/six.mp3',
    '7': 'audio/seven.mp3',
    '8': 'audio/eight.mp3',
    '9': 'audio/nine.mp3'
  };

  @override
  void initState() {
    super.initState();
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  void speakRandomNumber() {
    if (isFirstTime) {
      isFirstTime = false; // Set the flag to false after speaking the number
    }
    Random random = Random();
    int index = random.nextInt(numbers.length);
    String number = numbers[index];
    playSound(numberAudios[number] ?? '');
    setState(() {
      currentNumber = number;
      selectedNumber = '';
      isCorrectAnswer = false;
    });
  }

  void checkAnswer(String number) {
    if (!isListenButtonPressed) {
      // Show alert if user tries to select number without pressing "Listen" button
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Alert'),
          content: Text('Please listen to the number first.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      selectedNumber = number;
      isCorrectAnswer = number == currentNumber;
    });
    if (isCorrectAnswer) {
      playSound("audio/yay.mp3");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Correct Answer!'),
          content: Image.asset(
            "images/correct.gif",
            width: 100,
            height: 100,
          ),
        ),
      ).then((value) {
        setState(() {
          selectedNumber = '';
          isCorrectAnswer = false;
        });
      });
    } else {
      playSound("audio/wrong.mp3");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Wrong Answer!'),
          content: Image.asset(
            "images/tomwrong.gif",
            width: 100,
            height: 100,
          ),
        ),
      ).then((value) {
        setState(() {
          selectedNumber = '';
          isCorrectAnswer = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Number Exercise',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      speakRandomNumber();
                      setState(() {
                        isListenButtonPressed = true;
                      });
                    },
                    child: Text('Listen'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: currentNumber.isNotEmpty
                        ? () => playSound(numberAudios[currentNumber] ?? '')
                        : null,
                    child: Text('Listen Again'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Select the correct number:',
                style: TextStyle(fontSize: 17, fontFamily: 'openDyslexic'),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: numbers.map((number) {
                  return GestureDetector(
                    onTap: () {
                      if (!isCorrectAnswer) {
                        checkAnswer(number);
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedNumber == number
                            ? (isCorrectAnswer ? Colors.green : Colors.red)
                            : Colors.blue,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        number,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontFamily: 'openDyslexic'),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
