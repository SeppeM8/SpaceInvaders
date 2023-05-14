import "package:flutter/cupertino.dart";

import "../game.dart";

/// A special ability
abstract class Ability {
  /// The image of the button to activate the ability.
  abstract final AssetImage image;

  /// The game.
  final SpaceGame game;

  /// Constructor.
  Ability(this.game);

  /// Executes the special action.
  void execute();
}
