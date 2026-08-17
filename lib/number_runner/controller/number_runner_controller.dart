import 'package:flutter/foundation.dart';

import '../models/number_game_model.dart';

class NumberRunnerController extends ChangeNotifier {
  int score = 0;

  int currentMissionIndex = 0;

  bool gameOver = false;

  bool gameCompleted = false;

  final Set<String> collectedObjects = {};

  List<NumberMissionModel> missions = [];

  void setMissions(
      List<NumberMissionModel> value,
      ) {
    missions = value;

    currentMissionIndex = 0;
    score = 0;

    gameOver = false;
    gameCompleted = false;

    collectedObjects.clear();

    notifyListeners();
  }

  NumberMissionModel? get currentMission {
    if (missions.isEmpty) {
      return null;
    }

    if (currentMissionIndex >= missions.length) {
      return null;
    }

    return missions[currentMissionIndex];
  }

  bool collectNumber(
      NumberObjectModel object,
      ) {
    if (gameOver || gameCompleted) {
      return false;
    }

    if (collectedObjects.contains(object.id)) {
      return false;
    }

    // Wrong number
    if (!object.correct) {
      gameOver = true;

      notifyListeners();

      return false;
    }

    // Correct number
    collectedObjects.add(object.id);

    score += 10;

    notifyListeners();

    // Next mission
    if (currentMissionIndex < missions.length - 1) {
      currentMissionIndex++;

      collectedObjects.clear();
    } else {
      gameCompleted = true;
    }

    notifyListeners();

    return true;
  }

  void missedNumber() {
    if (gameOver || gameCompleted) {
      return;
    }

    gameOver = true;

    notifyListeners();
  }

  void hitObstacle() {
    if (gameOver || gameCompleted) {
      return;
    }

    gameOver = true;

    notifyListeners();
  }

  void restartGame() {
    currentMissionIndex = 0;

    score = 0;

    gameOver = false;

    gameCompleted = false;

    collectedObjects.clear();

    notifyListeners();
  }
}