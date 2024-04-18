import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MonkeyCountingPage(),
    );
  }
}

class MonkeyCountingPage extends StatefulWidget {
  @override
  _MonkeyCountingPageState createState() => _MonkeyCountingPageState();
}

class _MonkeyCountingPageState extends State<MonkeyCountingPage> {
  int monkeyCount = 0;
  int correctAnswerIndex = 0;
  List<String> options = [];
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    generateMonkeyCount();
  }

  void generateMonkeyCount() {
    Random random = Random();
    monkeyCount = random.nextInt(9) + 1; // Generate random count from 1 to 9
    correctAnswerIndex =
        random.nextInt(4); // Randomly select correct answer index
    List<String> allOptions = List.generate(9, (index) => '${index + 1}');
    allOptions.shuffle(); // Shuffle the list of options
    options = allOptions.sublist(0, 4); // Select the first four options
    options[correctAnswerIndex] = '$monkeyCount'; // Set correct option
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Monkey Counting Game'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select the correct number of monkeys',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            // Display monkey image multiple times based on monkey count
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: monkeyCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      'images/monkey.png', // Replace with actual image path
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            // Display options for user to select
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: options
                  .asMap()
                  .entries
                  .map(
                    (entry) => ElevatedButton(
                      onPressed: () {
                        if (entry.key == correctAnswerIndex) {
                          // User selected correct option
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
                          playSound("audio/yay.mp3");
                        } else {
                          // User selected wrong option
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
                          playSound("audio/wrong.mp3");
                        }
                      },
                      child: Text(entry.value),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  generateMonkeyCount();
                });
              },
              child: Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }
}
