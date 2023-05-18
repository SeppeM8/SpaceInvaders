import "package:flame/components.dart";
import "package:flame/events.dart";
import "package:flame/game.dart";

import "../models/game_model.dart";
import "../widgets/overlays/game_over_menu.dart";
import "../widgets/overlays/pause_button.dart";
import "sprites/bullet.dart";
import "sprites/enemy/linear_enemy.dart";
import "sprites/explosion.dart";
import "sprites/player.dart";

/// The main game class.
class SpaceGame extends FlameGame
    with HasTappables, KeyboardEvents, HasCollisionDetection {
  /// The game model.
  late GameModel gameModel;

  /// The player sprite.
  final Player player = Player();

  /// The list of explosion sprites.
  late List<Sprite> explosionSprites = [];

  /// Add an explosion at the given position.
  void addExplosion(Vector2 position) {
    final explosion = Explosion();
    explosion.position = position;
    add(explosion);
  }

  @override
  Future<void> onLoad() async {
    final backgroundImage = await images.load("background2.jpg");
    final sprite = SpriteComponent.fromImage(
      backgroundImage,
      size: size,
    );
    add(sprite);

    for (int i = 1; i <= 27; i++) {
      explosionSprites.add(await loadSprite("explosion/explosion_$i.png"));
    }

    addAll([
      player,
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    gameModel.update(dt);

    if (player.isMounted && gameModel.lives <= 0) {
      pauseEngine();
      overlays.remove(PauseButton.id);
      overlays.add(GameOverMenu.id);
    }
  }

  /// Reset the game.
  void reset() {
    player.reset();
    gameModel.reset();

    children.whereType<Bullet>().forEach((bullet) => bullet.removeFromParent());
    children
        .whereType<LinearEnemy>()
        .forEach((monster) => monster.removeFromParent());
    children.whereType<Explosion>().forEach((explosion) {
      explosion.removeFromParent();
    });
  }

  /// Initialize/Replace the current game model.
  void setGameModel(GameModel gameModel) {
    this.gameModel = gameModel;
  }
}
