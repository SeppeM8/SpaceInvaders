import 'dart:async' as async;
import 'dart:core';
import 'dart:math';

import 'package:flame/components.dart';

import '../main.dart';

class EnemiesModel {
  final Game game;

  final speedup = 10;
  final fastest = 10000;

  int time = 5000;
  async.Timer? timer;
  Random rng = Random();

  EnemiesModel(this.game) {
    timer = async.Timer(Duration(milliseconds: time), spawnRandomMonster);
  }

  void spawnRandomMonster() {
    final double position = rng.nextDouble() * 2 * (game.size.x + game.size.y);
    if (position < 2 * game.size.x) {
      game.addMonster(Vector2(position, 0));
    } else if (position < game.size.x + game.size.y) {
      game.addMonster(Vector2(game.size.x, position - game.size.x));
    } else if (position < 2 * game.size.x + game.size.y) {
      game.addMonster(Vector2(
          game.size.x - (position - game.size.x - game.size.y), game.size.y));
    } else {
      game.addMonster(
          Vector2(0, game.size.y - (position - 2 * game.size.x - game.size.y)));
    }

    time -= speedup;
    if (time < fastest) {
      time = fastest;
    }
    timer = async.Timer(Duration(milliseconds: time), spawnRandomMonster);
  }
}
