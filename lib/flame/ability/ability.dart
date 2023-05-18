import "package:flutter/cupertino.dart";

import "../../models/player_model.dart";
import "../game.dart";

/// A special ability
abstract class Ability {
  /// The image of the button to activate the ability.
  abstract final AssetImage image;

  /// The player model.
  late PlayerModel playerModel;

  /// The game.
  final SpaceGame game;

  /// Constructor.
  Ability(this.game);

  /// Executes the special action.
  void execute(PlayerModel playerModel) {
    this.playerModel = playerModel;
  }

  /// Updates the ability.
  void update(double dt) {
    // Do nothing.
  }

  /// Notifies the player model that the ability has finished.
  void abilityFinished() {
    playerModel.abilityFinished();
  }
}
