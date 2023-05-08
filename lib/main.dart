import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "screens/main_menu.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      fontFamily: "BungeeInline",
      scaffoldBackgroundColor: Colors.black,
    ),
    home: const MainMenu(),
  ));
}
