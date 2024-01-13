import "dart:async";

import "package:flame/collisions.dart";
import "package:flame/components.dart";

import "../game.dart";

/// The explosion class
class Money extends SpriteComponent
    with HasGameRef<SpaceGame>, CollisionCallbacks {
  // Properties
  static const double _rotationSpeed = 0.1;
  static const int _frameCount = 10;
  static const List<double> _valueTimes = [3, 6, 11];
  static const List<int> _values = [5, 2, 1];

  /// The current value of the money.
  int get value => _values[_valueIndex];

  // Status
  int _currentFrame = 0;
  double _rotationTimer = 0.0;
  double _lifeTimer = 0.0;
  int _valueIndex = 0;

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
    _lifeTimer += dt;
    if (_lifeTimer >= _valueTimes[_valueIndex]) {
      if (_valueIndex < _valueTimes.length - 1) {
        _valueIndex++;
      } else {
        game.remove(this);
      }
    }

    _rotationTimer -= dt;
    if (_rotationTimer <= 0) {
      _rotationTimer = _rotationSpeed;
      _currentFrame++;
      if (_currentFrame >= _frameCount) {
        _currentFrame = 0;
      }
      sprite = game.moneySprites[_valueIndex * 10 + _currentFrame];
    }

    super.update(dt);
  }
}
