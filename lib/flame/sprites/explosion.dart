import "dart:async";

import "package:flame/components.dart";

import "../game.dart";

/// The explosion class
class Explosion extends SpriteComponent with HasGameRef<SpaceGame> {
  // Properties
  final double _explosionSpeed = 0.05;

  // Status
  int _explosionFrame = 0;
  double _explosionTimer = 0.0;

  @override
  Future<void> onLoad() async {
    sprite = game.explosionSprites[0];
    anchor = Anchor.center;
    priority = 3;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _explosionTimer -= dt;
    if (_explosionTimer <= 0) {
      _explosionTimer = _explosionSpeed;
      _explosionFrame++;
      if (_explosionFrame >= game.explosionSprites.length - 1) {
        game.remove(this);
      }
      sprite = game.explosionSprites[_explosionFrame];
    }

    super.update(dt);
  }
}
