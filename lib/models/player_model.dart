import "../flame/ability/ability.dart";
import "game_model.dart";

/// The player model.
class PlayerModel {
  final GameModel _gameModel;

  /// The ability which is available to the player.
  Ability? ability;

  /// Whether the ability is active.
  bool abilityActive = false;

  /// Constructor.
  PlayerModel(this._gameModel) : super();

  /// Add a special ability to the player.
  void addSpecial(Ability ability) {
    this.ability = ability;
    _gameModel.notify();
  }

  /// Updates the player model.
  void update(double dt) {
    if (ability != null) {
      ability!.update(dt);
    }
  }

  /// Ability finished.
  void abilityFinished() {
    abilityActive = false;
    ability = null;
    _gameModel.notify();
  }

  /// Use the special ability of the player.
  void useAbility() {
    if (ability == null) {
      return;
    }
    abilityActive = true;
    ability!.execute(this);
    _gameModel.notify();
  }

  /// Resets the player model.
  void reset() {
    ability = null;
    abilityActive = false;
  }
}
