import "package:flutter/material.dart";
import "../../../flame/game.dart";
import "../../../utils/consts.dart";
import "control_button.dart";

/// The controls for the player.
class PlayerControls extends StatelessWidget {
  /// The id of this widget.
  static const String id = "playerControls";

  final SpaceGame _game;

  /// Constructor.
  const PlayerControls({Key? key, required SpaceGame game})
      : _game = game,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            ControlButton(
                onDown: () => {_game.player.isAccelerating = true},
                onUp: () => {_game.player.isAccelerating = false},
                iconData: Icons.arrow_circle_up),
            ControlButton(
              onDown: () => {_game.player.isShooting = true},
              onUp: () => {_game.player.isShooting = false},
              iconData: Icons.radio_button_checked,
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            ControlButton(
                onDown: () => {_game.player.rotation = Rotation.LEFT},
                onUp: () => {_game.player.rotation = Rotation.NONE},
                iconData: Icons.arrow_left,
                size: 100.0),
            ControlButton(
                onDown: () => {_game.player.rotation = Rotation.RIGHT},
                onUp: () => {_game.player.rotation = Rotation.NONE},
                iconData: Icons.arrow_right,
                size: 100.0),
          ],
        ),
      ],
    );
  }
}
