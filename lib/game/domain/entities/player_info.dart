enum PlayerType {
  ui,
  ai,
}

final class PlayerInfo {
  PlayerInfo(String? name, {this.type})
      : id = _counter,
        name = name ?? "Player";

  static int __counter = 0;
  static int get _counter => __counter++;

  final int id;
  final String name;

  // TODO? perhaps remove from [PlayerInfo] layer
  final PlayerType? type;

  bool get isUi => type == PlayerType.ui;
  bool get isAi => type == PlayerType.ai;

  @override
  bool operator ==(Object other) => other is PlayerInfo && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
