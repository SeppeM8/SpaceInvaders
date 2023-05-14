import "dart:developer";

import "package:flutter/cupertino.dart";

import "../flame/game.dart";
import "enemies_model.dart";
import "player_model.dart";

/// A model that holds the score and lives of the player.
class GameModel extends ChangeNotifier {
  /// The game.
  final SpaceGame game;

  /// The score of the player.
  int score = 0;

  /// The lives of the player.
  int lives = 3;

  /// The enemies model.
  late EnemiesModel enemiesModel;

  /// The player model.
  late PlayerModel playerModel;

  /// Constructor.
  GameModel({required this.game}) {
    enemiesModel = EnemiesModel(this);
    playerModel = PlayerModel(this);
  }

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

  /// Notifies the listeners.
  void notify() {
    notifyListeners();
  }

  /// Updates the game model.
  void update(double dt) {
    enemiesModel.update(dt);
  }

  /// Resets the score and lives to their default values.
  void reset() {
    enemiesModel.reset();
    score = 0;
    lives = 3;
    notifyListeners();
  }
}
