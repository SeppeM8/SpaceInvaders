import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../main.dart';
import '../utils/vectorCalculations.dart';
import 'monster.dart';

class Bullet extends SpriteComponent with HasGameRef<Game>, CollisionCallbacks {
  Vector2 velocity;

  Bullet(double angle, double speed)
      : velocity = vectorFromAngle(angle) * speed;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    sprite = await gameRef.loadSprite('bullet1.png');
    width = 30;
    height = 75;
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;

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
