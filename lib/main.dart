import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_invaders/sprites/monster.dart';

import 'models/enemiesModel.dart';
import 'sprites/bullet.dart';
import 'sprites/player.dart';
import 'sprites/rotationButton.dart';
import 'utils/consts.dart';

class Game extends FlameGame
    with HasTappables, KeyboardEvents, HasCollisionDetection {
  late Player player;
  late RotationButton leftButton;
  late EnemiesModel enemiesModel;

  late List<Sprite> explosionSprites = [];

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    for (int i = 1; i <= 27; i++) {
      explosionSprites.add(await loadSprite('explosion/explosion_$i.png'));
    }

    player = Player();

    add(player);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyQ) {
        player.rotation = Rotation.LEFT;
      } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
        player.rotation = Rotation.RIGHT;
      } else if (event.logicalKey == LogicalKeyboardKey.keyZ) {
        player.isAccelerating = true;
      } else if (event.logicalKey == LogicalKeyboardKey.space) {
        player.isShooting = true;
      }
    } else if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyQ ||
          event.logicalKey == LogicalKeyboardKey.keyD) {
        player.rotation = Rotation.NONE;
      } else if (event.logicalKey == LogicalKeyboardKey.keyZ) {
        player.isAccelerating = false;
      } else if (event.logicalKey == LogicalKeyboardKey.space) {
        player.isShooting = false;
      }
    }
    return KeyEventResult.handled;
  }

  void setEnemiesModel(EnemiesModel enemiesModel) {
    this.enemiesModel = enemiesModel;
  }

  void addBullet(Vector2 position, double angle, double speed) {
    final Bullet bullet = Bullet(angle, speed);
    bullet.position = position;
    bullet.angle = angle;
    add(bullet);
  }

  void addMonster(Vector2 position) {
    final Monster monster = Monster(player);
    monster.position = position;
    add(monster);
  }
}

void main() {
  final Game game = Game();
  final EnemiesModel enemiesModel = EnemiesModel(game);
  game.setEnemiesModel(enemiesModel);
  runApp(GameWidget(game: game));
}
