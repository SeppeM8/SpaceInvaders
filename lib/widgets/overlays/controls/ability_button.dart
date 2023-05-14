import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../models/game_model.dart";

/// Button to activate an ability.
class AbilityButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(builder: (context, gameModel, child) {
      if (gameModel.playerModel.ability == null) {
        return const SizedBox.shrink();
      }
      return Align(
          alignment: Alignment.bottomLeft,
          child: IconButton(
              onPressed: () => gameModel.playerModel.useSpecial(),
              icon: ImageIcon(gameModel.playerModel.ability!.image),
              iconSize: 50.0));
    });
  }
}
