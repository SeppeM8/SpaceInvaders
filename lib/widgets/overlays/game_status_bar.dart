import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../models/game_model.dart";

/// A widget that displays the score and lives of the player.
class GameStatusBar extends StatelessWidget {
  /// The id of this widget.
  static const String id = "gameStatusBar";

  /// Constructor.
  const GameStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(builder: (context, gameModel, child) {
      return Row(
        children: [
          Text(
            "Score: ${gameModel.score}",
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          Text(
            " Lives: ${gameModel.lives}",
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ],
      );
    });
  }
}
