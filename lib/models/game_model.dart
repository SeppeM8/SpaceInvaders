import "dart:math";

import "package:flutter/cupertino.dart";
import "package:hive/hive.dart";

import "../flame/game.dart";
import "enemies_model.dart";
import "game_data.dart";
import "player_model.dart";

/// A model that holds the score and lives of the player.
class GameModel extends ChangeNotifier {
  // Status

  /// The score of the player.
  int score = 0;

  /// The high score of the player.
  int get highScore => data.highScore;

  /// Sets the high score of the player.
  set highScore(int value) {
    data.highScore = value;
    data.save();
    notifyListeners();
  }

  /// The money of the player.
  int get money => data.money;

  /// Sets the money of the player.
  set money(int value) {
    data.money = value;
    data.save();
    notifyListeners();
  }

  /// Adds money to the player.
  void addMoney(int value) {
    data.money += value;
    data.save();
    notifyListeners();
  }

  /// The lives of the player.
  int lives = 3;

  /// The game object.
  SpaceGame? game;

  /// The enemies model.
  late EnemiesModel enemiesModel;

  /// The player model.
  late PlayerModel playerModel;

  /// The random number generator.
  final Random rng = Random();

  /// The box that holds the game data.
  final GameData data;

  /// Constructor.
  GameModel(Box<GameData> box)
      : data = box.get("main", defaultValue: GameData.defaultData)! {
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
    playerModel.reset();
    score = 0;
    lives = 3;
    notifyListeners();
  }

  /// Game over.
  void gameOver() {
    if (score > highScore) {
      highScore = score;
    }
  }

  /// Sets the game object.
  void setGame(SpaceGame game) {
    this.game = game;
  }
}
