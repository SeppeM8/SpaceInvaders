import "package:flame/collisions.dart";
import "package:flame/components.dart";

import "../../utils/vector_calculations.dart";
import "../game.dart";
import "monster.dart";

/// The bullet class
class Bullet extends SpriteComponent
    with HasGameRef<SpaceGame>, CollisionCallbacks {
  final Vector2 _velocity;

  /// Constructor.
  Bullet(double angle, double speed)
      : _velocity = vectorFromAngle(angle) * speed;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    sprite = await gameRef.loadSprite("bullet1.png");
    width = 30;
    height = 75;
    anchor = Anchor.center;
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

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Monster) {
      game.remove(this);
    }
  }
}
