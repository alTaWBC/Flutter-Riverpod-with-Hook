import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Keeps Game State
class GameController extends ChangeNotifier {
  ///Saves Card States
  List<GlobalKey<FlipCardState>> cardStateKeys = [];

  /// Saves the
  List<bool> cardFlips = [];

  /// Saves card data
  List<String> data = [];

  /// Saves card turned
  int previousIndex = -1;

  /// Controls game Logic
  bool flip = false;

  /// Game time
  int time = 0;

  /// Game Time changer
  Timer timer;

  /// Default constructor
  GameController();

  /// Starts user Timer
  void startTime() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      time = time + 1;
      notifyListeners();
    });
  }

  /// Initiates game
  void initState(int size) {
    for (var i = 0; i < size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
      notifyListeners();
    }
    _populateData(size);
    _populateData(size);
    data.shuffle();
    startTime();
  }

  void _populateData(int size) {
    for (var i = 0; i < size ~/ 2; i++) {
      data.add(i.toString());
      notifyListeners();
    }
  }

  /// see if cards are equal
  void matchCard(int index, BuildContext context) {
    if (!flip) {
      flip = true;
      previousIndex = index;
      notifyListeners();
    } else {
      flip = false;

      if (index == previousIndex) return;

      if (data[previousIndex] != data[index]) {
        cardStateKeys[previousIndex].currentState.toggleCard();
        previousIndex = index;
        notifyListeners();
      } else {
        cardFlips[previousIndex] = false;
        cardFlips[index] = false;
        notifyListeners();

        if (cardFlips.every((element) => element == false)) {
          print('Won');
          _showMessage(context);
        }
      }
    }
  }

  void _showMessage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('You Won!!'),
        content: Text('Time: $time'),
      ),
    );
  }
}

final gameProvider = ChangeNotifierProvider<GameController>((ref) => GameController());
