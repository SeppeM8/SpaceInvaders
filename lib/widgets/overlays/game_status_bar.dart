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
            "High Score: ${gameModel.highScore}",
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20.0),
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
          const SizedBox(width: 20.0),
          _MoneyWidget(money: gameModel.money),
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

class _MoneyWidget extends StatelessWidget {
  final int money;

  const _MoneyWidget({Key? key, required this.money}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Image(
          height: 20.0,
          image: AssetImage("assets/images/money/Gold_0.png"),
        ),
        Text(
          " $money",
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
