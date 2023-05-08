import "package:flame/collisions.dart";
import "package:flame/components.dart";

import "../../utils/vector_calculations.dart";
import "../game.dart";
import "bullet.dart";
import "explosion.dart";

/// The monster class
class Monster extends SpriteComponent
    with HasGameRef<SpaceGame>, CollisionCallbacks {
  // Properties
  final double _speed = 60;
  final double _colldingSpeed = 30;

  // Status
  bool _isCollidingWithMonster = false;

  /// Constructor.
  Monster({required Vector2 position}) : super(position: position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    sprite = await gameRef.loadSprite("monster1.png");
    width = 30;
    height = 30;
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // orientation
    angle = angleBetween(position, game.player.position);

    // position
    final currentSpeed = _isCollidingWithMonster ? _colldingSpeed : _speed;
    position += vectorFromAngle(angle) * currentSpeed * dt;
    _isCollidingWithMonster = false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bullet) {
      game.gameModel.increaseScoreBy(1);
      final explosion = Explosion();
      explosion.position = position;
      game.add(explosion);
      game.remove(this);
    } else if (other is Monster) {
      _isCollidingWithMonster = length(game.player.position - position) >
          length(game.player.position - other.position);
    }
  }
}