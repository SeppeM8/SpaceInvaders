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
            " Score: ${gameModel.score}",
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20.0),
          _LivesWidget(lives: gameModel.lives),
          const SizedBox(width: 20.0),
          Text(
            " Time: ${gameModel.enemiesModel.time.toStringAsFixed(1)}",
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

class _LivesWidget extends StatelessWidget {
  final int lives;

  const _LivesWidget({Key? key, required this.lives}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < lives; i++)
          const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        for (int i = lives; i < 3; i++)
          const Icon(
            Icons.favorite,
            color: Colors.grey,
          ),
      ],
    );
  }
}
