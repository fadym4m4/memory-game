import 'dart:math';
import 'package:memorygame/GridModle.dart';

class MemoryGame {
  List<GridModle> cards = [];
  List<int> flippedIndices = [];
  int score = 0;

  MemoryGame(List<GridModle> originalCards) {
    cards = List.from(originalCards)..addAll(originalCards);
    cards.shuffle(Random());
  }

  bool flipCard(int index) {
    if (index < 0 ||
        index >= cards.length ||
        cards[index]?.isMatched == true ||
        flippedIndices.contains(index)) {
      return false;
    }
    if (flippedIndices.length < 2) {
      flippedIndices.add(index);
      return true;
    }
    return false;
  }

  bool checkMatch() {
    if (flippedIndices.length == 2) {
      if (cards[flippedIndices[0]].imageUrl == cards[flippedIndices[1]].imageUrl) {
        cards[flippedIndices[0]].isMatched = true;
        cards[flippedIndices[1]].isMatched = true;
        score++;
        flippedIndices.clear();
        return true;
      }
      return false;
    }
    return false;
  }

  void clearFlippedIndices() {
    flippedIndices.clear();
  }

  bool cardFlipped(int index) {
    if (index < 0 || index >= cards.length || cards[index]?.isMatched == true) {
      return true;
    } else {
      return flippedIndices.contains(index);
    }
  }
}
