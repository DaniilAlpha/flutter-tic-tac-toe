enum GameMode {
  pvp,
  pve,
  eve,
}

abstract class Config {
  static const fieldSize = (w: 3, h: 3);

  static const gameMode = GameMode.pve;
}
