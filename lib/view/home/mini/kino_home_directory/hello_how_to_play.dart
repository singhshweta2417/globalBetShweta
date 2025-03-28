import 'package:flutter/material.dart';
import 'package:game_on/main.dart';


class HiloHowToPlay extends StatefulWidget {
  const HiloHowToPlay({super.key});

  @override
  State<HiloHowToPlay> createState() => _HiloHowToPlayState();
}

class _HiloHowToPlayState extends State<HiloHowToPlay> {
  @override
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(top: height*0.05, right: width*0.023, left: width*0.023),
          child: Container(
            height: height*0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade900,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'How To Play',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: height*0.04,
                          width: width*0.075,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade800,
                          ),
                          child: const Icon(
                            Icons.cancel_outlined,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(thickness: 0.2),

                  SizedBox(height: height*0.015),
                  const Text(
                    'Objective:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white54,),
                  ),
                  const Text(
                    'Guess if the next card will be higher or lower than the current one. The goal is to keep guessing correctly you win.',
                    style: TextStyle(fontSize: 14,   color: Colors.white,),
                  ),
                  SizedBox(height: height*0.015),
                  const Text(
                    'Game Setup:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,   color: Colors.white54,),
                  ),
                  const Text(
                    'The game uses a deck of 52 cards, with values from 1 to 13 (Ace = 1, Jack = 11, Queen = 12, King = 13). You start with a random card, and your task is to guess whether the next card will be higher or lower.',
                    style: TextStyle(fontSize: 14, color: Colors.white,),
                  ),
                  SizedBox(height: height*0.015),
                  const Text(
                    'How to Play:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,   color: Colors.white70,),
                  ),
                  const Text(
                    '1. The first card will be drawn and shown to you.\n'
                        '2. You must guess if the next card will be "higher" or "lower" than the current card.\n'
                        '3. If your guess is correct, the game winand your score is displayed.\n'
                        '4. If your guess is wrong, the game ends and your score is displayed.',
                    style: TextStyle(fontSize: 14,   color: Colors.white),
                  ),
                  SizedBox(height: height*0.015),
                  const Text(
                    'Scoring:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,   color: Colors.white54,),
                  ),
                  const Text(
                    'For each correct guess, you earn in high (2.10x) or low (1.57x). ',
                    style: TextStyle(fontSize: 14 ,  color: Colors.white,),
                  ),
                  SizedBox(height: height*0.01),

                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}