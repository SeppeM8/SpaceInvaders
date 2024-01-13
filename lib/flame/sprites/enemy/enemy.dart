import "dart:math";

import "package:flame/collisions.dart";
import "package:flame/components.dart";

import "../../../utils/vector_calculations.dart";
import "../../game.dart";
import "../ability_sprite.dart";
import "../bullet.dart";
import "../money.dart";

/// The enemy class
abstract class Enemy extends SpriteAnimationComponent
    with HasGameRef<SpaceGame>, CollisionCallbacks {
  // Properties
  /// Default speed.
  final double speed = 40;

  /// Speed when colliding with other Enemy.
  final double collidingSpeed = 25;

  // Status
  /// Whether the enemy is colliding with another enemy.
  bool isCollidingWithEnemy = false;

  final Random _random = Random();

  /// Constructor.
  Enemy({required Vector2 position}) : super(position: position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    anchor = Anchor.center;
    priority = 4;
  }

  /// Move the enemy to the player.
  @override
  void update(double dt) {
    super.update(dt);

    // orientation
    angle = angleBetween(position, game.player.position);

    // position
    final currentSpeed = isCollidingWithEnemy ? collidingSpeed : speed;
    position += vectorFromAngle(angle) * currentSpeed * dt;
    isCollidingWithEnemy = false;
  }

  /// Explode the enemy.
  void explode() {
    game.addExplosion(position);
    game.remove(this);
  }

  /// Collision with bullet causes explosion and removal of enemy.
  /// Collision with another enemy causes the enemy to slow down
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bullet && !other.isEnemyBullet) {
      game.gameModel.increaseScoreBy(1);
      if (_random.nextDouble() < 0.1) {
        game.add(AbilitySprite(position: position));
      } else if (_random.nextDouble() < 0.5) {
        game.add(Money(position: position));
      }

      explode();
    } else if (other is Enemy) {
      isCollidingWithEnemy = length(game.player.position - position) >
          length(game.player.position - other.position);
    }
  }
}
