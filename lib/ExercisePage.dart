import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

class ExercisePage extends StatefulWidget {
  final String selectedLetter;

  ExercisePage({required this.selectedLetter});

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<String> words = [];
  FlutterTts flutterTts = FlutterTts();
  Map<int, Color> buttonColors = {};
  final player = AudioPlayer();
  bool showCorrectImage = false;
  bool showWrongImage = false;

  @override
  void initState() {
    super.initState();
    generateWords();
    initializeButtonColors();
  }

  void generateWords() {
    // Define 100 words for each letter with the target letter appearing in different positions
    Map<String, List<String>> wordMap = {
      'A': [
        'apple',
        'glass',
        'apple',
        'glass',
        'flame',
        'branch',
        'brave',
        'plate',
        'sharp',
        'calm',
        'hang',
        'share',
        'race',
        'giant',
        'tail',
        'half',
        'track',
        'rally',
        'snail',
        'back',
        'grade',
        'grass',
        'nail',
        'jam',
        'add',
        'land',
        'mad',
        'stamp',
        'mast',
        'stain',
        'lake',
        'page',
        'male',
        'shake',
        'pal',
        'fast',
        'bake',
        'waste',
        'game',
        'tape',
        'cage',
        'fame',
        'lace',
        'drain',
        'gap',
        'cake',
        'praise',
        'sample',
        'parade',
        'pace',
        'mate',
        'fade',
        'sail',
        'late',
        'cast',
        'flag',
        'share',
        'madam',
        'camera',
        'fragile',
        'alarm',
        'tale',
        'flame',
        'trail',
        'place',
        'abate',
        'claim',
        'gaze',
        'awake',
        'flair',
        'glad',
        'splash',
        'tangle',
        'jar',
        'marble',
        'drama',
        'table',
        'crane',
        'faint',
        'bland',
        'label',
        'daze',
        'barge',
        'blame',
        'lame',
        'rag',
        'whale',
        'moan',
        // Add your words here
      ],
      'G': [],
      'H': [],
      'I': [],
      'J': [],
      'K': [],
      'L': [],
      'M': [],
      'N': [],
      'O': [],
      'P': [],
      'Q': [],
      'R': [],
      'S': [],
      'T': [],
      'U': [],
      'V': [],
      'W': [],
      'X': [],
      'Y': [],
      'Z': [],
      // Define words for other letters similarly
      // ...
    };

    // Randomly select eight words for the exercise
    words = wordMap[widget.selectedLetter]!;
    words.shuffle();
    words = words.take(8).toList();
  }

  void initializeButtonColors() {
    // Initialize button colors to blue
    for (int i = 0; i < words.length; i++) {
      buttonColors[i] = Colors.blue;
    }
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Exercise'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                generateWords();
                initializeButtonColors();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20),
                for (int i = 0; i < words.length; i++)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int j = 0; j < words[i].length; j++)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: ElevatedButton(
                              onPressed: () {
                                // Check if the selected letter matches the letter in the word
                                if (words[i][j].toLowerCase() ==
                                    widget.selectedLetter.toLowerCase()) {
                                  // Selected letter matches, change button color to green
                                  setState(() {
                                    buttonColors[i] = Colors.green;
                                    showCorrectImage = true;
                                    showWrongImage = false;
                                  });
                                  // Play correct sound effect
                                  playSound("audio/yay.mp3");
                                  // Set a delayed function to hide the image after 1 second
                                  Future.delayed(Duration(seconds: 3), () {
                                    setState(() {
                                      showCorrectImage = false;
                                    });
                                  });
                                } else {
                                  // Selected letter does not match, change button color to red
                                  setState(() {
                                    buttonColors[i] = Colors.red;
                                    showWrongImage = true;
                                    showCorrectImage = false;
                                  });
                                  // Play wrong sound effect
                                  playSound("audio/wrong.mp3");
                                  // Set a delayed function to hide the image after 1 second
                                  Future.delayed(Duration(seconds: 3), () {
                                    setState(() {
                                      showWrongImage = false;
                                    });
                                  });
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                  return buttonColors[i]!;
                                }),
                              ),
                              child: Text(
                                words[i][j],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors
                                      .white, // Change font color to white
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                            width:
                                9), // Add space between each word horizontally
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (showCorrectImage)
            Positioned(
              top: 200,
              right: 80,
              child: Image.asset(
                "images/Monkey2.gif",
                width: 250,
                height: 250,
              ),
            ),
          if (showWrongImage)
            Positioned(
              top: 100,
              right: 40,
              child: Image.asset(
                "images/thumbsDown.png",
                width: 200,
                height: 200,
              ),
            ),
        ],
      ),
    );
  }
}
