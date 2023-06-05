import "package:flutter_bloc/flutter_bloc.dart";
import "package:tic_tac_toe/game/domain/entities/field/field.dart";
import "package:tic_tac_toe/game/domain/entities/game/game.dart";
import "package:tic_tac_toe/game/domain/usecases/get_players_usecase.dart";
import "package:tic_tac_toe/game/domain/usecases/mark_usecase.dart";
import "package:tic_tac_toe/game/domain/usecases/pick_best_usecase.dart";
import "package:tic_tac_toe/game/domain/usecases/restart_game_usecase.dart";

final class GameCubit extends Cubit<GameState> {
  GameCubit({
    required GetPlayersUsecase getPlayersUsecase,
    required MarkUsecase markUsecase,
    required PickBestUsecase pickBestUsecase,
    required RestartGameUsecase restartGameUsecase,
  })  : _getPlayersUsecase = getPlayersUsecase,
        _markUsecase = markUsecase,
        _pickBestUsecase = pickBestUsecase,
        _restartGameUsecase = restartGameUsecase,
        super(GamePlaying(currentPlayer: getPlayersUsecase.currentPlayer)) {
    _updateTurn();
  }

  static const aiThinkingDuration = Duration(milliseconds: 400);
  static const gameEndingDuration = Duration(milliseconds: 3000);

  final GetPlayersUsecase _getPlayersUsecase;
  final MarkUsecase _markUsecase;
  final PickBestUsecase _pickBestUsecase;
  final RestartGameUsecase _restartGameUsecase;

  Player get _currentPlayer => _getPlayersUsecase.currentPlayer;

  void mark(FieldPos pos) {
    if (!_currentPlayer.info.isUi) return;

    _mark(pos);
  }

  void restart() {
    _restartGameUsecase();
    _updateTurn();
  }

  void _mark(FieldPos pos) {
    final isEnded = _markUsecase(pos);
    _updateTurn();
    if (isEnded) _endGame();
  }

  Future<void> _endGame() async {
    await Future.delayed(gameEndingDuration);
    emit(GameEnded(winner: _getPlayersUsecase.winner));
  }

  void _updateTurn() {
    emit(GamePlaying(currentPlayer: _currentPlayer));
    if (_currentPlayer.info.isAi) _markAi();
  }

  Future<void> _markAi() async {
    await Future.delayed(aiThinkingDuration);
    _mark(await _pickBestUsecase(_currentPlayer.cellValue));
  }
}

sealed class GameState {
  GameState();
}

final class GamePlaying extends GameState {
  GamePlaying({required this.currentPlayer});

  final Player currentPlayer;
}

final class GameEnded extends GameState {
  GameEnded({required this.winner});

  final Player? winner;
}
