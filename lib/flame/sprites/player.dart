import "package:flame/collisions.dart";
import "package:flame/components.dart";
import "package:flutter/services.dart";

import "../../utils/consts.dart";
import "../../utils/vector_calculations.dart";
import "../../widgets/overlays/controls/player_controls.dart";
import "../game.dart";
import "bullet.dart";
import "enemy/enemy.dart";

/// The player class
class Player extends SpriteComponent
    with HasGameRef<SpaceGame>, KeyboardHandler, CollisionCallbacks {
  late Sprite _idleSprite;
  final double _idleSpriteHeight = 30;

  late Sprite _thrustSprite;
  final double _thrustSpriteHeight = 37.7;

  // Properties
  final double _rotationSpeed = 2;
  final double _acceleration = 200;
  final double _drag = 0.97;
  final double _shootCooldown = 0.8;
  final double _shootSpeed = 500;
  final double _liveLostCooldown = 3;

  // Status
  /// The current velocity of the player
  Vector2 velocity = Vector2.zero();

  /// The current rotation direction of the player
  Rotation rotation = Rotation.NONE;

  /// Whether the player is accelerating
  bool isAccelerating = false;

  /// Whether the player is shooting
  bool isShooting = false;

  /// The current shoot timer
  double shootTimer = 0;

  /// The current live lost timer
  double ghostTimer = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    _idleSprite = await gameRef.loadSprite("player-sprite.png");
    _thrustSprite = await gameRef.loadSprite("player-sprite2.png");
    sprite = _idleSprite;

    x = gameRef.size.x / 2;
    y = gameRef.size.y / 5 * 4;
    width = 30;
    height = 30;
    anchor = Anchor.center;
    priority = 5;

    game.overlays.add(PlayerControls.id);
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyQ) {
        rotation = Rotation.LEFT;
      } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
        rotation = Rotation.RIGHT;
      } else if (event.logicalKey == LogicalKeyboardKey.keyZ) {
        isAccelerating = true;
      } else if (event.logicalKey == LogicalKeyboardKey.space) {
        isShooting = true;
      }
    } else if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyQ ||
          event.logicalKey == LogicalKeyboardKey.keyD) {
        rotation = Rotation.NONE;
      } else if (event.logicalKey == LogicalKeyboardKey.keyZ) {
        isAccelerating = false;
      } else if (event.logicalKey == LogicalKeyboardKey.space) {
        isShooting = false;
      }
    }
    return false;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Velocity
    if (isAccelerating) {
      sprite = _thrustSprite;
      height = _thrustSpriteHeight;
      anchor = Anchor(
        0.5,
        15 / _thrustSpriteHeight,
      );
      velocity += vectorFromAngle(angle) * _acceleration * dt;
    } else {
      sprite = _idleSprite;
      height = _idleSpriteHeight;
      anchor = const Anchor(0.5, 0.5);
      velocity *= _drag;
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
        angle -= dt * _rotationSpeed;
        break;
      case Rotation.RIGHT:
        angle += dt * _rotationSpeed;
        break;
      case Rotation.NONE:
        break;
    }

    // Shooting
    if (isShooting && shootTimer <= 0) {
      shootTimer = _shootCooldown;
      shoot();
    } else {
      shootTimer -= dt;
    }

    // Ghost
    if (ghostTimer > 0) {
      opacity = 1.0 - 0.5 * (ghostTimer / _liveLostCooldown);
      ghostTimer -= dt;
    } else {
      opacity = 1;
    }
  }

  /// Shoots a bullet from the player center with an optional angle
  void shoot({double? angle}) {
    angle ??= this.angle;
    final Bullet bullet = Bullet(angle, _shootSpeed, position);
    game.add(bullet);
  }

  /// Resets the player to the center of the screen
  void reset() {
    ghostTimer = 0;
    x = gameRef.size.x / 2;
    y = gameRef.size.y / 5 * 4;
    velocity = Vector2.zero();
    angle = 0;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (ghostTimer <= 0 &&
        (other is Enemy || (other is Bullet && other.isEnemyBullet))) {
      game.gameModel.removeLife();
      ghostTimer = _liveLostCooldown;
      opacity = 0.5;
      game.addExplosion(position);

      if (game.gameModel.lives > 0 && other is Enemy) {
        other.explode();
      }
    }
  }
}
