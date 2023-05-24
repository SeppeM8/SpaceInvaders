import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../models/game_model.dart";
import "game_play.dart";

/// The main menu screen.
class MainMenu extends StatefulWidget {
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  /// The audio player.
  AudioPlayer audioPlayer = AudioPlayer()
    ..play(AssetSource("audio/easy_music.mp3"))
    ..setReleaseMode(ReleaseMode.loop);

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(builder: (context, gameModel, child) {
      return Scaffold(
          body: Stack(children: [
        Align(
          child: Text("High Score: ${gameModel.highScore}"),
          alignment: Alignment.topLeft,
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Game title.
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                "Space Invaders",
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

            // Play button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  AudioPlayer().play(AssetSource("audio/interface1.mp3"));
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<GamePlay>(
                      builder: (context) => GamePlay(),
                    ),
                  );
                },
                child: const Text("Play"),
              ),
            ),
          ],
        )),
      ]));
    });
  }
}
