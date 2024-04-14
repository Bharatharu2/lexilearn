import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TamilAlphabetListeningPage extends StatefulWidget {
  @override
  _TamilAlphabetListeningPageState createState() =>
      _TamilAlphabetListeningPageState();
}

class _TamilAlphabetListeningPageState
    extends State<TamilAlphabetListeningPage> {
  final AudioPlayer player = AudioPlayer();
  String currentAlphabet = '';
  String selectedAlphabet = '';
  bool isCorrectAnswer = false;
  bool isFirstTime = false;

  List<String> alphabets = [
    'அ',
    'ஆ',
    'இ',
    'ஈ',
    'உ',
    'ஊ',
    'எ',
    'ஏ',
    'ஐ',
    'ஒ',
    'ஓ',
    'ஔ'
  ];

  Map<String, String> alphabetAudios = {
    'அ': 'audio/அ.mp3',
    'ஆ': 'audio/ஆ.mp3',
    'இ': 'audio/இ.mp3',
    'ஈ': 'audio/ஈ.mp3',
    'உ': 'audio/உ.mp3',
    'ஊ': 'audio/ஊ.mp3',
    'எ': 'audio/எ.mp3',
    'ஏ': 'audio/ஏ.mp3',
    'ஐ': 'audio/ஐ.mp3',
    'ஒ': 'audio/ஒ.mp3',
    'ஓ': 'audio/ஓ.mp3',
    'ஔ': 'audio/ஔ.mp3'
  };

  @override
  void initState() {
    super.initState();
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  void speakRandomAlphabet() {
    Random random = Random();
    int index = random.nextInt(alphabets.length);
    String alphabet = alphabets[index];
    playSound(alphabetAudios[alphabet] ?? '');
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

  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      speakRandomAlphabet();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tamil Alphabet Listening',
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
                    onPressed: isFirstTime ? null : speakRandomAlphabet,
                    child: Text('Listen'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: currentAlphabet.isNotEmpty
                        ? () => playSound(alphabetAudios[currentAlphabet] ?? '')
                        : null,
                    child: Text('Listen Again'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'சரியான எழுத்தை தேர்வு செய்யவும்:',
                style: TextStyle(fontSize: 17),
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
                        alphabet,
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
