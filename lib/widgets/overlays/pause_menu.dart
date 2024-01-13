import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";

import "../../flame/game.dart";
import "../../screens/main_menu.dart";
import "controls/player_controls.dart";
import "pause_button.dart";

/// This class represents the pause menu overlay.
class PauseMenu extends StatelessWidget {
  /// This is the id of this overlay.
  static const String id = "PauseMenu";
  final SpaceGame _game;

  /// Constructor.
  const PauseMenu({Key? key, required SpaceGame game})
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
              "Paused",
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

          // Resume button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                AudioPlayer().play(AssetSource("audio/interface1.mp3"));
                _game.resumeEngine();
                _game.overlays.remove(PauseMenu.id);
                _game.overlays.add(PauseButton.id);
                _game.overlays.add(PlayerControls.id);
              },
              child: const Text("Resume"),
            ),
          ),

          // Restart button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                AudioPlayer().play(AssetSource("audio/interface1.mp3"));
                _game.overlays.remove(PauseMenu.id);
                _game.overlays.add(PauseButton.id);
                _game.overlays.add(PlayerControls.id);
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
                AudioPlayer().play(AssetSource("audio/interface1.mp3"));
                _game.overlays.remove(PauseMenu.id);
                _game.reset();
                _game.resumeEngine();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<MainMenu>(
                    builder: (context) => MainMenu(),
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
