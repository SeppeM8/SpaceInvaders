import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../main.dart';
import '../utils/vectorCalculations.dart';
import 'bullet.dart';
import 'player.dart';

class Monster extends SpriteComponent
    with HasGameRef<Game>, CollisionCallbacks {
  // Properties
  double speed = 60;

  // Status
  bool exploding = false;
  int explosionFrame = 0;
  double explosionTimer = 0.0;
  double explosionSpeed = 0.1;

  Player player;

  Monster(this.player);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    sprite = await gameRef.loadSprite('monster1.png');
    width = 60;
    height = 60;
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (exploding) {
      explosionTimer -= dt;
      if (explosionTimer <= 0) {
        explosionTimer = explosionSpeed;
        explosionFrame++;
        if (explosionFrame >= game.explosionSprites.length - 1) {
          game.remove(this);
        }
        sprite = game.explosionSprites[explosionFrame];
      }
      return;
    }

    // orientation
    angle = angleBetween(position, player.position);

    // position
    position += vectorFromAngle(angle) * speed * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bullet && !exploding) {
      exploding = true;
      sprite = game.explosionSprites[0];
      width = 100;
      height = 100;
    }
  }
}
