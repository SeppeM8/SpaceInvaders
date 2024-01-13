import "package:hive/hive.dart";

part "game_data.g.dart";

/// A model that holds the score and lives of the player.
@HiveType(typeId: 1)
class GameData extends HiveObject {
  /// The default data.
  static GameData defaultData = GameData(highScore: 0, money: 0);

  /// Highest player score so far.
  @HiveField(0, defaultValue: 0)
  int highScore;

  /// The money of the player.
  @HiveField(1, defaultValue: 0)
  int money;

  /// Creates a new instance of [GameData] from given map.
  GameData({required this.highScore, required this.money});
}
