import "package:flame/components.dart";
import "package:flame/events.dart";
import "package:flame/game.dart";

import "../flame/models/enemies_model.dart";
import "../models/game_model.dart";
import "../widgets/overlays/game_over_menu.dart";
import "../widgets/overlays/pause_button.dart";
import "sprites/bullet.dart";
import "sprites/monster.dart";
import "sprites/player.dart";

/// The main game class.
class SpaceGame extends FlameGame
    with HasTappables, KeyboardEvents, HasCollisionDetection {
  /// The enemies model.
  final EnemiesModel enemiesModel = EnemiesModel();

  /// The game model.
  late GameModel gameModel;

  /// The player sprite.
  final Player player = Player();

  /// The list of explosion sprites.
  late List<Sprite> explosionSprites = [];

  @override
  Future<void> onLoad() async {
    for (int i = 1; i <= 27; i++) {
      explosionSprites.add(await loadSprite("explosion/explosion_$i.png"));
    }

    addAll([
      enemiesModel,
      player,
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (player.isMounted && gameModel.lives <= 0) {
      pauseEngine();
      overlays.remove(PauseButton.id);
      overlays.add(GameOverMenu.id);
    }
  }

  /// Reset the game.
  void reset() {
    player.reset();
    enemiesModel.reset();
    gameModel.reset();

    children.whereType<Bullet>().forEach((bullet) => bullet.removeFromParent());
    children
        .whereType<Monster>()
        .forEach((monster) => monster.removeFromParent());
  }

  /// Initialize/Replace the current game model.
  void setGameModel(GameModel gameModel) {
    this.gameModel = gameModel;
  }
}
