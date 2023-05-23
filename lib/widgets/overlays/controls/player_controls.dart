import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";
import "../../../flame/game.dart";
import "../../../utils/consts.dart";
import "ability_button.dart";
import "control_button.dart";
import "joystick.dart";

/// The controls for the player.
class PlayerControls extends StatefulWidget {
  /// The id of this widget.
  static const String id = "playerControls";

  final SpaceGame _game;

  /// Constructor.
  const PlayerControls({Key? key, required SpaceGame game})
      : _game = game,
        super(key: key);

  @override
  _PlayerControlsState createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  // Audio
  /// The audio player for the engine sound
  final AudioPlayer _audioPlayer = AudioPlayer()
    ..setSource(AssetSource("audio/engine.wav"))
    ..setReleaseMode(ReleaseMode.loop);

  @override
  Widget build(BuildContext context) {
    const bool joystick = true;

    return Row(
      children: [
        Row(
          children: [
            ControlButton(
                onDown: () => {
                      widget._game.player.isAccelerating = true,
                      _audioPlayer.resume()
                    },
                onUp: () => {
                      widget._game.player.isAccelerating = false,
                      _audioPlayer.pause()
                    },
                iconData: Icons.arrow_circle_up),
            ControlButton(
              onDown: () => {widget._game.player.isShooting = true},
              onUp: () => {widget._game.player.isShooting = false},
              iconData: Icons.radio_button_checked,
            ),
            AbilityButton(),
          ],
        ),
        const Spacer(),
        if (!joystick)
          Row(
            children: [
              ControlButton(
                  onDown: () => {widget._game.player.rotation = Rotation.LEFT},
                  onUp: () => {widget._game.player.rotation = Rotation.NONE},
                  iconData: Icons.arrow_left,
                  size: 100.0),
              ControlButton(
                  onDown: () => {widget._game.player.rotation = Rotation.RIGHT},
                  onUp: () => {widget._game.player.rotation = Rotation.NONE},
                  iconData: Icons.arrow_right,
                  size: 100.0),
            ],
          ),
        if (joystick) JoyStick(widget._game.player),
      ],
    );
  }
}
