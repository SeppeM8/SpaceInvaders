import "package:flame/components.dart";

import "../bullet.dart";
import "enemy.dart";

/// The monster class
class LinearShootingEnemy extends Enemy {
  // Properties
  /// The time between each bullet.
  final double _reloadingTime = 4.0;
  final double _bulletSpeed = 250.0;

  // Status
  /// The time elapsed since the last bullet.
  double _timeElapsed = 2.0;

  /// Constructor.
  LinearShootingEnemy({required Vector2 position}) : super(position: position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite("boss1.png");
    width = 40;
    height = 40;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Shoot
    _timeElapsed += dt;
    if (_timeElapsed >= _reloadingTime) {
      _shoot();
      _timeElapsed = 0.0;
    }
  }

  /// Shoot a bullet.
  void _shoot() {
    final bullet = Bullet(angle, _bulletSpeed, position, isEnemyBullet: true);
    gameRef.add(bullet);
  }
}
