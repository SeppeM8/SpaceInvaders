import "package:flutter/material.dart";

import "ability.dart";

/// A special ability that sends a cluster of bullets.
class ClusterAbility extends Ability {
  final int _bulletCount = 25;

  @override
  AssetImage image = const AssetImage("assets/images/cluster.png");

  /// Constructor.
  ClusterAbility(super.game);

  @override
  void execute() {
    for (int i = 0; i < _bulletCount; i++) {
      game.player.shoot(angle: 360.0 / _bulletCount * i);
    }
  }
}
