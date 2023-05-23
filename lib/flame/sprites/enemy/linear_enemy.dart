import "package:flame/components.dart";
import "package:flame/flame.dart";

import "enemy.dart";

/// The monster class
class LinearEnemy extends Enemy {
  /// Constructor.
  LinearEnemy({required Vector2 position}) : super(position: position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final image = await Flame.images.load("enemy_0/scout.png");
    final json = await Flame.assets.readJson("images/enemy_0/scout.json");

    animation = SpriteAnimation.fromAsepriteData(
      image,
      json,
    );

    width = 25;
  }
}
