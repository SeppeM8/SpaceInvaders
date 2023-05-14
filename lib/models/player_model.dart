import "../flame/ability/ability.dart";
import "game_model.dart";

/// The player model.
class PlayerModel {
  final GameModel _gameModel;

  /// The ability which is available to the player.
  Ability? ability;

  /// Constructor.
  PlayerModel(this._gameModel) : super();

  /// Add a special ability to the player.
  void addSpecial(Ability ability) {
    this.ability = ability;
    _gameModel.notify();
  }

  /// Use the special ability of the player.
  void useSpecial() {
    if (ability == null) {
      return;
    }
    ability!.execute();
    ability = null;
    _gameModel.notify();
  }
}
