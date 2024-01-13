import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";

import "../../flame/game.dart";
import "controls/player_controls.dart";
import "pause_menu.dart";

/// This class represents the pause button overlay.
class PauseButton extends StatelessWidget {
  /// This is the id of this overlay.
  static const String id = "PauseButton";

  final SpaceGame _game;

  /// Constructor.
  const PauseButton({Key? key, required SpaceGame game})
      : _game = game,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        child: const Icon(
          Icons.pause_circle_outline,
          color: Colors.grey,
          size: 30.0,
        ),
        onPressed: () {
          AudioPlayer().play(AssetSource("audio/interface1.mp3"));
          _game.pauseEngine();
          _game.overlays.add(PauseMenu.id);
          _game.overlays.remove(PauseButton.id);
          _game.overlays.remove(PlayerControls.id);
        },
      ),
    );
  }
}
