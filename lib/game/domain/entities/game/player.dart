part of "game.dart";

final class Player {
  Player(this.info);

  final PlayerInfo info;

  // ignore: prefer_final_fields
  var _score = 0;
  int get score => _score;

  late CellValue _cellValue;
  CellValue get cellValue => _cellValue;
}
