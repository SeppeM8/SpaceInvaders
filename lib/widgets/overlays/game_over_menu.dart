import "package:flutter/material.dart";

import "../../flame/game.dart";
import "../../screens/main_menu.dart";
import "pause_button.dart";

/// This class represents the game over menu overlay.
class GameOverMenu extends StatelessWidget {
  /// This is the id of this overlay.
  static const String id = "GameOverMenu";

  final SpaceGame _game;

  /// Constructor.
  const GameOverMenu({Key? key, required SpaceGame game})
      : _game = game,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pause menu title.
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              "Game Over",
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),

          // Restart button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                _game.overlays.remove(GameOverMenu.id);
                _game.overlays.add(PauseButton.id);
                _game.reset();
                _game.resumeEngine();
              },
              child: const Text("Restart"),
            ),
          ),

          // Exit button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                _game.overlays.remove(GameOverMenu.id);
                _game.reset();
                _game.resumeEngine();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<MainMenu>(
                    builder: (context) => const MainMenu(),
                  ),
                );
              },
              child: const Text("Exit"),
            ),
          ),
        ],
      ),
    );
  }
}
