import 'package:flutter/material.dart';
import 'package:hangman/ui/colors.dart';
import 'package:hangman/ui/widget/figure_image.dart';
import 'package:hangman/ui/widget/letter.dart';
import 'package:hangman/utils/game.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  String word = wordlist[Random().nextInt(wordlist.length)];
  List<String> alphabets = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('images/hangmann.png'),
          Center(
            child: Stack(
              children: [
                figureImage(Game.tries >= 0, 'images/hang.png'),
                figureImage(Game.tries >= 1, 'images/head.png'),
                figureImage(Game.tries >= 2, 'images/body.png'),
                figureImage(Game.tries >= 3, 'images/ra.png'),
                figureImage(Game.tries >= 4, 'images/la.png'),
                figureImage(Game.tries >= 5, 'images/rl.png'),
                figureImage(Game.tries >= 6, 'images/ll.png'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: word
                .split('')
                .map((e) => letter(e.toUpperCase(),
                    Game.selectedChar.contains(e.toUpperCase())))
                .toList(),
          ),
          SizedBox(
              width: double.infinity,
              height: 250.0,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 7,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                padding: EdgeInsets.all(8.0),
                children: alphabets.map((e) {
                  return RawMaterialButton(
                    onPressed: Game.selectedChar.contains(e)
                        ? null
                        : () {
                            setState(() {
                              bool isWon = true;
                              Game.selectedChar.add(e);
                              print(Game.selectedChar);
                              String guess = Game.selectedChar.join();
                              print(guess);
                              if (!word.split('').contains(e.toUpperCase())) {
                                Game.tries++;
                              }
                              if (Game.tries > 7 && guess != word) {
                                print('you lost');
                                bool isWon = false;
                              } else {
                                print('you won');
                              }

                              for (int i = 0; i < word.length; i++) {
                                String char = word[i];
                                if (Game.tries > 7 && guess != word) {
                                  bool isWon = false;
                                  break;
                                }

                                if (isWon) {
                                  print('WON');
                                }
                              }
                            });
                          },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      e,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    fillColor: Game.selectedChar.contains(e)
                        ? Colors.black87
                        : Colors.green,
                  );
                }).toList(),
              ))
        ],
      ),
    );
  }
}
