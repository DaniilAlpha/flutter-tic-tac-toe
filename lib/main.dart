import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tic_tac_toe/core/data/config.dart";
import "package:tic_tac_toe/core/domain/math.dart";
import "package:tic_tac_toe/core/presentation/my_theme.dart";
import "package:tic_tac_toe/game/domain/entities/ai.dart";
import "package:tic_tac_toe/game/domain/entities/field/field.dart";
import "package:tic_tac_toe/game/domain/entities/game/game.dart";
import "package:tic_tac_toe/game/domain/entities/player_info.dart";
import "package:tic_tac_toe/game/domain/usecases/get_players_usecase.dart";
import "package:tic_tac_toe/game/domain/usecases/mark_usecase.dart";
import "package:tic_tac_toe/game/domain/usecases/pick_best_usecase.dart";
import "package:tic_tac_toe/game/domain/usecases/restart_game_usecase.dart";
import "package:tic_tac_toe/game/presentation/bloc/game_cubit.dart";
import "package:tic_tac_toe/game/presentation/ui/game_page.dart";

const _humanNames = [
  "Unlucky Luke",
  "Miss Fortune",
  "Epic Fail",
  "Loser Larry",
  "Bad Luck Brian",
];
const _aiNames = [
  "Ovuvuevuevue Enyetuenwuevue Ugbemugbem Osas",
  "The Terminator",
  "Noob Crusher",
  "Invictus",
  "Zero Error",
];
final humanName = _humanNames[rng.nextInt(_humanNames.length)];
final aiName = _aiNames[rng.nextInt(_aiNames.length)];

final _field = Field(Config.fieldSize.w, Config.fieldSize.h);
final _game = Game(
  field: _field,
  playerInfos: switch (Config.gameMode) {
    GameMode.pvp => [
        PlayerInfo(humanName, type: PlayerType.ui),
        PlayerInfo(aiName, type: PlayerType.ui),
      ],
    GameMode.pve => [
        PlayerInfo(humanName, type: PlayerType.ui),
        PlayerInfo(aiName, type: PlayerType.ai),
      ],
    GameMode.eve => [
        PlayerInfo(humanName, type: PlayerType.ai),
        PlayerInfo(aiName, type: PlayerType.ai),
      ],
  },
);
final _ai = Ai(field: _field);

final _getPlayersUsecase = GetPlayersUsecase(_game);
final _markUsecase = MarkUsecase(_game);
final _pickBestUsecase = PickBestUsecase(_ai);
final _restartGameUsecase = RestartGameUsecase(_game);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: BlocProvider(
          create: (_) => GameCubit(
            getPlayersUsecase: _getPlayersUsecase,
            markUsecase: _markUsecase,
            pickBestUsecase: _pickBestUsecase,
            restartGameUsecase: _restartGameUsecase,
          ),
          child: GamePage(field: _field),
        ),
        theme: MyTheme.theme,
      );
}
