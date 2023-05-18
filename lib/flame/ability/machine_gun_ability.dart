import "package:flutter/material.dart";

import "../../models/player_model.dart";
import "ability.dart";

/// A special ability that sends a cluster of bullets.
class MachineGunAbility extends Ability {
  // Properties
  final int _bulletCount = 25;
  final double _fireTempo = 0.15;

  // Status
  double _fireTimer = 1.0;
  int _bulletCounter = 0;
  bool _firing = false;

  @override
  AssetImage image = const AssetImage("assets/images/machineGun.png");

  /// Constructor.
  MachineGunAbility(super.game);

  @override
  void execute(PlayerModel playerModel) {
    super.execute(playerModel);
    _firing = true;
  }

  @override
  void update(double dt) {
    if (_firing) {
      _fireTimer += dt;
      if (_fireTimer >= _fireTempo) {
        _fireTimer = 0.0;
        _bulletCounter++;
        game.player.shoot();
        if (_bulletCounter >= _bulletCount) {
          _firing = false;
          abilityFinished();
        }
      }
    }
  }
}
