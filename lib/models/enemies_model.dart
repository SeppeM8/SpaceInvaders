import "dart:core";
import "dart:math";

import "package:flame/components.dart";

import "../flame/game.dart";
import "../flame/sprites/monster.dart";
import "game_model.dart";

/// The enemies model.
class EnemiesModel {
  final GameModel _gameModel;
  late SpaceGame _game;
  double time = 4.0;
  double _timeElapsed = 0.0;
  final Random _rng = Random();

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

  void _spawnRandomMonster() {
    final double position =
        _rng.nextDouble() * 2 * (_game.size.x + _game.size.y);
    Vector2 monsterPosition;
    if (position < 2 * _game.size.x) {
      monsterPosition = Vector2(position, 0);
    } else if (position < _game.size.x + _game.size.y) {
      monsterPosition = Vector2(_game.size.x, position - _game.size.x);
    } else if (position < 2 * _game.size.x + _game.size.y) {
      monsterPosition = Vector2(
          _game.size.x - (position - _game.size.x - _game.size.y),
          _game.size.y);
    } else {
      monsterPosition = Vector2(
          0, _game.size.y - (position - 2 * _game.size.x - _game.size.y));
    }

    final Monster monster = Monster(position: monsterPosition);
    _game.add(monster);

    _changeTime();
    _gameModel.notify();
  }

  /// Updates the model.
  void update(double dt) {
    _timeElapsed += dt;
    if (_timeElapsed >= time) {
      _spawnRandomMonster();
      _timeElapsed = 0.0;
    }
  }

  /// Reset the model.
  void reset() {
    time = 4.0;
  }
}
