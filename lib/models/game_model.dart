import "dart:math";

import "package:flutter/cupertino.dart";

import "../flame/game.dart";
import "enemies_model.dart";
import "player_model.dart";

// Creating this as a file private object so as to
// avoid unwanted rebuilds of the whole game object.
/// A model that holds the score and lives of the player.
class GameModel extends ChangeNotifier {
  /// Returns the game object.
  SpaceGame? game;

  /// The score of the player.
  int score = 0;

  /// The lives of the player.
  int lives = 3;

  /// The enemies model.
  late EnemiesModel enemiesModel;

  /// The player model.
  late PlayerModel playerModel;

  /// The random number generator.
  final Random rng = Random();

  /// Constructor.
  GameModel() {
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
    playerModel.update(dt);
  }

  /// Resets the score and lives to their default values.
  void reset() {
    enemiesModel.reset();
    score = 0;
    lives = 3;
    notifyListeners();
  }

  /// Sets the game object.
  void setGame(SpaceGame game) {
    this.game = game;
  }
}
