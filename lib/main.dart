import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "models/game_model.dart";
import "screens/main_menu.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GameModel()),
  ], child: const App()));
}

/// The entrypoint of the application.
class App extends StatelessWidget {
  /// The entrypoint of the application.
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "BungeeInline",
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MainMenu(),
    );
  }
}
