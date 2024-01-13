import "package:flame/collisions.dart";
import "package:flame/components.dart";
import "package:flame/flame.dart";
import "package:flame/image_composition.dart";
import "package:flame_audio/flame_audio.dart";
import "package:flutter/services.dart";

import "../../utils/consts.dart";
import "../../utils/vector_calculations.dart";
import "../../widgets/overlays/controls/player_controls.dart";
import "../game.dart";
import "bullet.dart";
import "enemy/enemy.dart";
import "money.dart";

/// The player class
class Player extends SpriteAnimationComponent
    with HasGameRef<SpaceGame>, KeyboardHandler, CollisionCallbacks {
  late SpriteAnimation _idleSprite;

  late SpriteAnimation _thrustSprite;

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

    final json = await Flame.assets.readJson("images/player/animation.json");

    final composition1 = ImageComposition()
      ..add(await Flame.images.load("player/engine_0_idle.png"), Vector2.zero())
      ..add(await Flame.images.load("player/hull_3.png"), Vector2.zero());
    final image1 = await composition1.compose();

    final composition2 = ImageComposition()
      ..add(
          await Flame.images.load("player/engine_0_power.png"), Vector2.zero())
      ..add(await Flame.images.load("player/hull_3.png"), Vector2.zero());
    final image2 = await composition2.compose();

    _idleSprite = SpriteAnimation.fromAsepriteData(
      image1,
      json,
    );

    _thrustSprite = SpriteAnimation.fromAsepriteData(
      image2,
      json,
    );

    animation = _idleSprite;

    width = 40;

    final hitbox = PolygonHitbox.relative(
        [Vector2(0, -0.6), Vector2(0.75, 0.7), Vector2(-0.75, 0.7)],
        parentSize: Vector2.all(width));

    add(hitbox);

    x = gameRef.size.x / 2;
    y = gameRef.size.y / 5 * 4;
    anchor = Anchor.center;
    priority = 5;
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
      animation = _thrustSprite;
      velocity += vectorFromAngle(angle) * _acceleration * dt;
    } else {
      animation = _idleSprite;
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
      case Rotation.RIGHT:
        angle += dt * _rotationSpeed;
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

    if (other is Money) {
      game.gameModel.addMoney(other.value);
      game.remove(other);
      FlameAudio.play("coin.mp3");
    }

    if (ghostTimer <= 0 &&
        (other is Enemy || (other is Bullet && other.isEnemyBullet))) {
      game.gameModel.removeLife();
      ghostTimer = _liveLostCooldown;
      opacity = 0.5;

      if (game.gameModel.lives > 0 && other is Enemy) {
        other.explode();
      }
    }
  }
}
