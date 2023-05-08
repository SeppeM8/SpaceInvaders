import "package:flutter/material.dart";

/// A button that can be pressed and released.
class ControlButton extends StatefulWidget {
  final VoidCallback _onDown;
  final VoidCallback _onUp;
  final IconData _iconData;

  final double _size;

  /// Creates a new control button.
  const ControlButton(
      {required void Function() onDown,
      required void Function() onUp,
      required IconData iconData,
      double size = 75.0,
      Key? key})
      : _size = size,
        _iconData = iconData,
        _onUp = onUp,
        _onDown = onDown,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ControlButtonState();
  }
}

class _ControlButtonState extends State<ControlButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: GestureDetector(
          onPanDown: (details) =>
              {widget._onDown(), setState(() => _isPressed = true)},
          onPanEnd: (details) =>
              {widget._onUp(), setState(() => _isPressed = false)},
          child: Icon(widget._iconData,
              size: widget._size,
              color: _isPressed
                  ? Colors.blue.withOpacity(0.75)
                  : Colors.grey.withOpacity(0.75)),
        ));
  }
}
