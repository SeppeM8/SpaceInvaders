import "dart:developer";

import "package:flutter/cupertino.dart";

/// A model that holds the score and lives of the player.
class GameModel extends ChangeNotifier {
  /// The score of the player.
  int score = 0;

  /// The lives of the player.
  int lives = 3;

  /// Increases the score by given value.
  void increaseScoreBy(int value) {
    score += value;
    notifyListeners();
  }

  /// Removes a life from the player.
  void removeLife() {
    log("removeLife");
    lives--;
    notifyListeners();
  }

  /// Resets the score and lives to their default values.
  void reset() {
    score = 0;
    lives = 3;
    notifyListeners();
  }
}
