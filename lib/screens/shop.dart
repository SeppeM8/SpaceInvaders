import "package:flutter/material.dart";

/// This class represents the pause menu overlay.
class Shop extends StatelessWidget {
  /// This is the id of this overlay.
  static const String id = "Shop";

  /// Constructor.
  const Shop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Shop title.
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: Text(
            "Shop",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Upgrade button.
          ],
        ),
      ],
    ));
  }
}
