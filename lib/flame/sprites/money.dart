import "dart:async";

import "package:flame/collisions.dart";
import "package:flame/components.dart";

import "../game.dart";

/// The explosion class
class Money extends SpriteComponent
    with HasGameRef<SpaceGame>, CollisionCallbacks {
  // Properties
  final double _rotationSpeed = 0.1;
  final int _frameCount = 10;

  /// The value of the money.
  final int value = 1;

  // Status
  int _currentFrame = 0;
  double _rotationTimer = 0.0;

  /// Constructor.
  Money({required Vector2 position})
      : super(position: position, scale: Vector2.all(0.4));

  @override
  Future<void> onLoad() async {
    sprite = game.moneySprites[0];
    anchor = Anchor.center;
    priority = 3;

    add(CircleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _rotationTimer -= dt;
    if (_rotationTimer <= 0) {
      _rotationTimer = _rotationSpeed;
      _currentFrame++;
      if (_currentFrame >= _frameCount) {
        _currentFrame = 0;
      }
      sprite = game.moneySprites[_currentFrame];
    }

    super.update(dt);
  }
}
