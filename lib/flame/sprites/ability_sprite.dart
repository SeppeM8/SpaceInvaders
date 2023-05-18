import "dart:math";

import "package:flame/collisions.dart";
import "package:flame/components.dart";

import "../ability/cluster_ability.dart";
import "../ability/machine_gun_ability.dart";
import "../game.dart";
import "player.dart";

/// A sprite which can be collected by the player to get an ability.
class AbilitySprite extends SpriteComponent
    with HasGameRef<SpaceGame>, CollisionCallbacks {
  final Random _random = Random();

  // Properties
  final double _rotationSpeed = 1;
  final double _shrinkingSpeed = 1;

  /// Constructor.
  AbilitySprite({required Vector2 position}) : super(position: position);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(RectangleHitbox());

    sprite = await gameRef.loadSprite("mushroom.png");
    width = 30;
    height = 30;
    anchor = Anchor.center;
    priority = 2;
  }

  @override
  void update(double dt) {
    angle += _rotationSpeed * dt;
    size -= Vector2.all(_shrinkingSpeed) * dt;
    if (size.x <= 0 || size.y <= 0) {
      game.remove(this);
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      if (_random.nextInt(2) == 0) {
        game.gameModel.playerModel.addSpecial(MachineGunAbility(game));
      } else {
        game.gameModel.playerModel.addSpecial(ClusterAbility(game));
      }
      game.remove(this);
    }
  }
}
