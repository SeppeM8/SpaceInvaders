import "package:flame/collisions.dart";
import "package:flame/components.dart";
import "package:flame/flame.dart";

import "../../utils/vector_calculations.dart";
import "../game.dart";
import "enemy/enemy.dart";
import "player.dart";

/// The bullet class
class Bullet extends SpriteAnimationComponent
    with HasGameRef<SpaceGame>, CollisionCallbacks {
  // Properties
  final Vector2 _velocity;

  /// Whether the bullet is an enemy bullet.
  final bool isEnemyBullet;

  /// Constructor.
  Bullet(double angle, double speed, Vector2 position,
      {this.isEnemyBullet = false})
      : _velocity = vectorFromAngle(angle) * speed,
        super(angle: angle, position: position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    final image = await Flame.images.load("projectile_0.png");
    final json = await Flame.assets.readJson("images/projectile_0.json");

    animation = SpriteAnimation.fromAsepriteData(
      image,
      json,
    );

    width = 10;
    anchor = Anchor.center;
    priority = 1;
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _velocity * dt;

    if (position.x < 0 ||
        position.x > gameRef.size.x ||
        position.y < 0 ||
        position.y > gameRef.size.y) {
      game.remove(this);
    }
  }

  /// This onCollision only removes the bullet from the game.
  /// The actual logic is handled in the other class.
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if ((isEnemyBullet && other is Player) ||
        (!isEnemyBullet && other is Enemy)) {
      game.remove(this);
    } else if (other is Bullet && isEnemyBullet) {
      game.remove(this);
      game.remove(other);
      game.addExplosion(intersectionPoints.first);
    }
  }
}
