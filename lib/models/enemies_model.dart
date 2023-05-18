import "dart:core";

import "package:flame/components.dart";

import "../flame/game.dart";
import "../flame/sprites/enemy/enemy.dart";
import "../flame/sprites/enemy/linear_enemy.dart";
import "../flame/sprites/enemy/linear_shooting_enemy.dart";
import "game_model.dart";

/// The enemies model.
class EnemiesModel {
  // Properties
  /// The time between each enemy spawn.
  double time = 4.0;

  // Status
  /// The time elapsed since the last enemy spawn.
  double _timeElapsed = 0.0;

  final GameModel _gameModel;
  late SpaceGame _game;

  /// Constructor.
  EnemiesModel(this._gameModel) : super() {
    _game = _gameModel.game;
  }

  void _changeTime() {
    if (time > 3.0) {
      time -= 0.1;
    } else if (time > 2.0) {
      time -= 0.05;
    } else if (time > 1.0) {
      time -= 0.02;
    } else if (time > 0.5) {
      time -= 0.002;
    }
  }

  void _spawnRandomEnemy() {
    const double margin = 30;

    final double position =
        _gameModel.rng.nextDouble() * 2 * (_game.size.x + _game.size.y);
    Vector2 enemyPosition;
    if (position < _game.size.x) {
      enemyPosition = Vector2(position, -margin);
    } else if (position < _game.size.x + _game.size.y) {
      enemyPosition = Vector2(_game.size.x + margin, position - _game.size.x);
    } else if (position < 2 * _game.size.x + _game.size.y) {
      enemyPosition = Vector2(
          _game.size.x - (position - _game.size.x - _game.size.y),
          _game.size.y + margin);
    } else {
      enemyPosition = Vector2(
          -margin, _game.size.y - (position - 2 * _game.size.x - _game.size.y));
    }

    final Enemy enemy = (_gameModel.rng.nextDouble() < 0.9)
        ? LinearEnemy(position: enemyPosition)
        : LinearShootingEnemy(position: enemyPosition);
    _game.add(enemy);

    _changeTime();
    _gameModel.notify();
  }

  /// Updates the model.
  void update(double dt) {
    _timeElapsed += dt;
    if (_timeElapsed >= time) {
      _spawnRandomEnemy();
      _timeElapsed = 0.0;
    }
  }

  /// Reset the model.
  void reset() {
    time = 4.0;
  }
}
