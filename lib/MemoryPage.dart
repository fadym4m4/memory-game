import 'dart:async';
import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memorygame/GridModle.dart';
import 'package:memorygame/MemoryGame.dart';

class MemoryPage extends StatefulWidget {
  const MemoryPage({super.key});

  @override
  State<MemoryPage> createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {

  List<GridModle> allData = [
    GridModle(Qimage: 'assets/images/shapeq.png', imageUrl: 'assets/images/shape_a.png'),
    GridModle(Qimage: 'assets/images/shapeq.png', imageUrl: 'assets/images/shape_b.png'),
    GridModle(Qimage: 'assets/images/shapeq.png', imageUrl: 'assets/images/shape_c.png'),
    GridModle(Qimage: 'assets/images/shapeq.png', imageUrl: 'assets/images/shape_d.png'),
    GridModle(Qimage: 'assets/images/shapeq.png', imageUrl: 'assets/images/shape_e.png'),
    GridModle(Qimage: 'assets/images/shapeq.png', imageUrl: 'assets/images/shape_f.png'),
  ];

  late MemoryGame game;

  @override
  void initState() {
    super.initState();
    game = MemoryGame(allData);
  }

  void handleCardFlip(int index) {
    setState(() {
      if (game.flipCard(index)) {
        if (game.flippedIndices.length == 2) {
          bool isMatch = game.checkMatch();
          if (!isMatch) {
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                game.clearFlippedIndices();
              });
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text('Memory Game'),
        ),
        body: Column(children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(game.score == 6 ? 'Congratulations!' : 'Score: ${game.score}',
                style: TextStyle(fontSize: 24, color: Colors.white)),

          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),

                itemCount: game.cards.length,
                itemBuilder: (context, index) {
                  final isFlipped = game.cardFlipped(index);

                  final item = game.cards[index];

                  return FlipCard(
                    fill: Fill.fillBack,
                    direction: FlipDirection.HORIZONTAL,
                    flipOnTouch: !isFlipped && game.flippedIndices.length <= 2,
                    onFlipDone: (isFront) {
                      if (!isFront) {
                        handleCardFlip(index);
                      }
                    },
                    side: CardSide.BACK,
                    front: Container(
                      child: Image.asset('${item.imageUrl}'),
                    ),
                    back: Container(
                      child: Image.asset('${item.Qimage}'),
                    ),
                  );
                }
                ),
          ),
        ]
        ),
      ),
    );
  }
}
