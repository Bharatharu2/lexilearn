import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

class AlphabetListeningPage extends StatefulWidget {
  @override
  _AlphabetListeningPageState createState() => _AlphabetListeningPageState();
}

class _AlphabetListeningPageState extends State<AlphabetListeningPage> {
  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer player = AudioPlayer();
  String currentAlphabet = '';
  String selectedAlphabet = '';
  bool isCorrectAnswer = false;
  bool isFirstTime = false; // Flag to control speaking alphabet at the start

  List<String> alphabets = List.generate(
      26, (index) => String.fromCharCode('a'.codeUnitAt(0) + index));

  @override
  void initState() {
    super.initState();
  }

  Future<void> playSound(String audiopath) async {
    await flutterTts.setSpeechRate(0.2);
    await player.play(AssetSource(audiopath));
  }

  void speakRandomAlphabet() async {
    Random random = Random();
    int index = random.nextInt(alphabets.length);
    String alphabet = alphabets[index];
    await flutterTts.speak(alphabet);
    setState(() {
      currentAlphabet = alphabet;
      selectedAlphabet = '';
      isCorrectAnswer = false;
      isFirstTime = false; // Set the flag to false after speaking the alphabet
    });
  }

  void checkAnswer(String alphabet) {
    setState(() {
      selectedAlphabet = alphabet;
      isCorrectAnswer = alphabet == currentAlphabet;
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
          selectedAlphabet = '';
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
          selectedAlphabet = '';
          isCorrectAnswer = false;
        });
      });
    }
  }

  void speakSoundAlphabet(String alphabet) async {
    await flutterTts.speak(alphabet);
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      speakRandomAlphabet();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alphabet Listening',
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
                    onPressed: speakRandomAlphabet,
                    child: Text('Listen'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => speakSoundAlphabet(currentAlphabet),
                    child: Text('Listen Again'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Select the correct alphabet:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: alphabets.map((alphabet) {
                  return GestureDetector(
                    onTap: () {
                      if (!isCorrectAnswer) {
                        checkAnswer(alphabet);
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedAlphabet == alphabet
                            ? (isCorrectAnswer ? Colors.green : Colors.red)
                            : Colors.blue,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        alphabet.toUpperCase(),
                        style: TextStyle(fontSize: 24, color: Colors.white),
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
