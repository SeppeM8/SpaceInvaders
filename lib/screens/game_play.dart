import "package:flame/game.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../flame/game.dart";
import "../models/game_model.dart";
import "../widgets/overlays/controls/player_controls.dart";
import "../widgets/overlays/game_over_menu.dart";
import "../widgets/overlays/game_status_bar.dart";
import "../widgets/overlays/pause_button.dart";
import "../widgets/overlays/pause_menu.dart";

// Creating this as a file private object so as to
// avoid unwanted rebuilds of the whole game object.
final _spaceGame = SpaceGame();

/// This class represents the actual game screen
class GamePlay extends StatelessWidget {
  /// Constructor.
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => GameModel(),
        child: Consumer<GameModel>(builder: (context, gameModel, child) {
          _spaceGame.setGameModel(gameModel);
          return Scaffold(
            // WillPopScope provides us a way to decide if
            // this widget should be poped or not when user
            // presses the back button.
            body: WillPopScope(
              onWillPop: () async => false,
              // GameWidget is useful to inject the underlying
              // widget of any class extending from Flame's Game class.
              child: GameWidget(game: _spaceGame, initialActiveOverlays: const [
                PauseButton.id,
                GameStatusBar.id
              ], overlayBuilderMap: {
                PauseButton.id: (BuildContext context, SpaceGame game) =>
                    PauseButton(
                      game: game,
                    ),
                PauseMenu.id: (BuildContext context, SpaceGame game) =>
                    PauseMenu(
                      game: game,
                    ),
                PlayerControls.id: (BuildContext context, SpaceGame game) =>
                    PlayerControls(
                      game: game,
                    ),
                GameOverMenu.id: (BuildContext context, SpaceGame game) =>
                    GameOverMenu(
                      game: game,
                    ),
                GameStatusBar.id: (BuildContext context, SpaceGame game) =>
                    const GameStatusBar(),
              }),
            ),
          );
        }));
  }
}
