import "package:flame/components.dart";

import "enemy.dart";

/// The monster class
class LinearEnemy extends Enemy {
  /// Constructor.
  LinearEnemy({required Vector2 position}) : super(position: position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite("monster1.png");
    width = 30;
    height = 30;
  }
}
