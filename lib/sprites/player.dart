import 'package:flame/components.dart';

import '../main.dart';
import '../utils/consts.dart';
import '../utils/vectorCalculations.dart';

class Player extends SpriteComponent with HasGameRef<Game> {
  // Properties
  double rotationSpeed = 2;
  double acceleration = 200;
  double drag = 0.97;
  double shootCooldown = 0.8;
  double shootSpeed = 500;

  // Status
  Vector2 velocity = Vector2.zero();
  Rotation rotation = Rotation.NONE;
  bool isAccelerating = false;
  bool isShooting = false;
  double shootTimer = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('player-sprite.png');

    position = gameRef.size / 2;
    width = 75;
    width = 75;
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Velocity
    if (isAccelerating) {
      velocity += vectorFromAngle(angle) * acceleration * dt;
    } else {
      velocity *= drag;
    }

    // Position
    position += velocity * dt;

    // Fix borders
    if (position.x < 0) {
      position.x = 0;
      velocity.x = 0;
    } else if (position.x > gameRef.size.x) {
      position.x = gameRef.size.x;
      velocity.x = 0;
    }
    if (position.y < 0) {
      position.y = 0;
      velocity.y = 0;
    } else if (position.y > gameRef.size.y) {
      position.y = gameRef.size.y;
      velocity.y = 0;
    }

    // Orientation
    switch (rotation) {
      case Rotation.LEFT:
        angle -= dt * rotationSpeed;
        break;
      case Rotation.RIGHT:
        angle += dt * rotationSpeed;
        break;
      case Rotation.NONE:
        break;
    }

    // Shooting
    if (isShooting && shootTimer <= 0) {
      shootTimer = shootCooldown;
      gameRef.addBullet(position, angle, shootSpeed);
    }

    shootTimer -= dt;
  }
}
