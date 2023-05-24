import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:provider/provider.dart";
import "models/game_data.dart";
import "models/game_model.dart";
import "screens/main_menu.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await Hive.initFlutter();
  Hive.registerAdapter(GameDataAdapter());
  final box = await Hive.openBox<GameData>("game_data");

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GameModel(box)),
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
