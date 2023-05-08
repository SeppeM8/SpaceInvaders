import "dart:core";
import "dart:math";

import "package:flame/components.dart";

import "../game.dart";
import "../sprites/monster.dart";

/// The enemies model.
class EnemiesModel extends Component with HasGameRef<SpaceGame> {
  double _time = 4.0;
  Timer? _timer;
  final Random _rng = Random();

  /// Constructor.
  EnemiesModel() : super() {
    _timer = Timer(_time, onTick: _spawnRandomMonster, repeat: true);
  }

  void _changeTime() {
    if (_time > 3.0) {
      _time -= 0.1;
    } else if (_time > 2.0) {
      _time -= 0.05;
    } else if (_time > 1.0) {
      _time -= 0.04;
    } else if (_time > 0.5) {
      _time -= 0.02;
    }
  }

  void _spawnRandomMonster() {
    final double position = _rng.nextDouble() * 2 * (game.size.x + game.size.y);
    Vector2 monsterPosition;
    if (position < 2 * game.size.x) {
      monsterPosition = Vector2(position, 0);
    } else if (position < game.size.x + game.size.y) {
      monsterPosition = Vector2(game.size.x, position - game.size.x);
    } else if (position < 2 * game.size.x + game.size.y) {
      monsterPosition = Vector2(
          game.size.x - (position - game.size.x - game.size.y), game.size.y);
    } else {
      monsterPosition =
          Vector2(0, game.size.y - (position - 2 * game.size.x - game.size.y));
    }

    final Monster monster = Monster(position: monsterPosition);
    game.add(monster);

    _changeTime();

    _timer?.limit = _time;
  }

  @override
  void update(double dt) {
    _timer?.update(dt);
    super.update(dt);
  }

  /// Reset the model.
  void reset() {
    _time = 4.0;
    _timer?.limit = _time;
  }
}
