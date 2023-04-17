import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../main.dart';
import '../utils/consts.dart';

class RotationButton extends SpriteComponent with Tappable, HasGameRef<Game> {
  void Function(Rotation) rotate;
  Rotation rotation;

  RotationButton(this.rotation, this.rotate);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await game.loadSprite('button-left.png');
    width = 100;
    height = 100;
    anchor = Anchor.center;
    position = Vector2(game.size.x - 150, game.size.y - 150);
    if (rotation == Rotation.RIGHT) {
      angle = pi;
    }
  }

  @override
  bool onTapUp(TapUpInfo info) {
    rotate(Rotation.NONE);
    return true;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    rotate(rotation);
    return true;
  }

  @override
  bool onTapCancel() {
    return true;
  }
}
