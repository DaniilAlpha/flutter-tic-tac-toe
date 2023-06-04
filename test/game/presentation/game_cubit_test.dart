import "package:flutter_test/flutter_test.dart";
import "package:tic_tac_toe/game/domain/entities/ai.dart";
import "package:tic_tac_toe/game/domain/entities/field/field.dart";
import "package:tic_tac_toe/game/domain/entities/game/game.dart";
import "package:tic_tac_toe/game/domain/entities/player_info.dart";
import "package:tic_tac_toe/game/domain/usecases/get_players_usecase.dart";
import "package:tic_tac_toe/game/domain/usecases/mark_usecase.dart";
import "package:tic_tac_toe/game/domain/usecases/pick_best_usecase.dart";
import "package:tic_tac_toe/game/domain/usecases/restart_game_usecase.dart";
import "package:tic_tac_toe/game/presentation/bloc/game_cubit.dart";

void main() {
  final playerInfo = PlayerInfo(null);

  late Field field;
  late Game game;
  late Ai ai;
  late GameCubit cubit;

  setUp(() {
    field = Field(1, 1);
    game = Game(field: field, playerInfos: [playerInfo]);
    ai = Ai(field: field);
    cubit = GameCubit(
      getPlayersUsecase: GetPlayersUsecase(game),
      markUsecase: MarkUsecase(game),
      pickBestUsecase: PickBestUsecase(ai),
      restartGameUsecase: RestartGameUsecase(game),
    );
  });

  test("initial state is 'playing'", () {
    expect(cubit.state.runtimeType, GamePlaying);
  });

  test("winning game make state 'ended' and saves winner", () async {
    cubit.mark(const FieldPos(0, 0));
    expect((cubit.state as GameEnded).winner!.info, playerInfo);
  });
}
