import "dart:math";

import "package:flame/components.dart";
import "package:flutter/material.dart";

import "../../../flame/sprites/player.dart";
import "../../../utils/vector_calculations.dart";

/// The joystick for the player.
class JoyStick extends StatefulWidget {
  /// The radius of the big circle.
  static double radius = 60;

  /// The radius of the small circle.
  static double stickRadius = 15;

  /// The player object.
  final Player player;

  /// Constructor.
  const JoyStick(this.player);

  @override
  _JoyStickState createState() => _JoyStickState();
}

class _JoyStickState extends State<JoyStick> {
  final GlobalKey _joyStickContainer = GlobalKey();
  double yOff = 0, xOff = 0;
  double _x = JoyStick.radius, _y = JoyStick.radius;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final RenderBox renderBoxWidget =
          _joyStickContainer.currentContext?.findRenderObject() as RenderBox;
      final offset = renderBoxWidget.localToGlobal(Offset.zero);

      xOff = offset.dx;
      yOff = offset.dy;
    });
  }

  void _onPointerMove(PointerEvent details) {
    final x = details.position.dx - xOff;
    final y = details.position.dy - yOff;

    final angle =
        angleFromVector(Vector2(x - JoyStick.radius, y - JoyStick.radius));

    widget.player.angle = angle;

    final absX = pow((x - JoyStick.radius).abs(), 2.0);
    final absY = pow((y - JoyStick.radius).abs(), 2.0);
    if (sqrt(absX + absY) < JoyStick.radius - JoyStick.stickRadius) {
      setState(() {
        _x = x;
        _y = y;
      });
    } else {
      final v = vectorFromAngle(angle);
      setState(() {
        _x = v.x * (JoyStick.radius - JoyStick.stickRadius) + JoyStick.radius;
        _y = v.y * (JoyStick.radius - JoyStick.stickRadius) + JoyStick.radius;
      });
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _x = JoyStick.radius;
      _y = JoyStick.radius;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
            padding: const EdgeInsets.only(right: 40, bottom: 20),
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerMove: _onPointerMove,
              onPointerUp: _onPointerUp,
              child: Container(
                key: _joyStickContainer,
                width: JoyStick.radius * 2,
                height: JoyStick.radius * 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(JoyStick.radius),
                  color: Colors.grey.withOpacity(0.6),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: _x - JoyStick.stickRadius,
                      top: _y - JoyStick.stickRadius,
                      child: Container(
                        width: JoyStick.stickRadius * 2,
                        height: JoyStick.stickRadius * 2,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius:
                              BorderRadius.circular(JoyStick.stickRadius),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
