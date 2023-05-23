import "package:flame/components.dart";
import "package:flame/events.dart";
import "package:flame/game.dart";
import "package:flame/image_composition.dart";

import "../models/game_model.dart";
import "../widgets/overlays/game_over_menu.dart";
import "../widgets/overlays/pause_button.dart";
import "sprites/bullet.dart";
import "sprites/enemy/enemy.dart";
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
  late List<Sprite> explosionSprites;

  /// Add an explosion at the given position.
  void addExplosion(Vector2 position) {
    final explosion = Explosion();
    explosion.position = position;
    add(explosion);
  }

  /// Set the game model.
  void setGameModel(GameModel gameModel) {
    this.gameModel = gameModel;
    gameModel.game = this;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final backgroundImage = await images.load("background/stars_0.png");

    final background = ImageComposition()..add(backgroundImage, Vector2.zero());

    for (int i = 1; i * 512 < size.x; i++) {
      background.add(backgroundImage, Vector2(i * 512, 0));
      for (int j = 1; j * 512 < size.y; j++) {
        background.add(backgroundImage, Vector2(i * 512, j * 512));
      }
    }

    final sprite = SpriteComponent.fromImage(
      await background.compose(),
      size: size,
    );
    add(sprite);

    final List<Future<Sprite>> loadingTasks = [];

    for (int i = 1; i <= 27; i++) {
      loadingTasks.add(loadSprite("explosion/explosion_$i.png"));
    }

    explosionSprites = await Future.wait(loadingTasks);

    debugMode = false;

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
        .whereType<Enemy>()
        .forEach((monster) => monster.removeFromParent());
    children.whereType<Explosion>().forEach((explosion) {
      explosion.removeFromParent();
    });
  }
}
