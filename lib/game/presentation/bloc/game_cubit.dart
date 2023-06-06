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
  static const gameEndingDuration = Duration(milliseconds: 800);

  final GetPlayersUsecase _getPlayersUsecase;
  final MarkUsecase _markUsecase;
  final PickBestUsecase _pickBestUsecase;
  final RestartGameUsecase _restartGameUsecase;

  Player get _currentPlayer => _getPlayersUsecase.currentPlayer;

  Future<void> mark(FieldPos pos) async {
    if (!_currentPlayer.info.isUi) return;

    await _mark(pos);
  }

  Future<void> restart() async {
    _restartGameUsecase();
    await _updateTurn();
  }

  Future<void> _mark(FieldPos pos) async {
    final isEnded = _markUsecase(pos);
    isEnded ? await _endGame() : await _updateTurn();
  }

  Future<void> _endGame() async {
    emit(GamePlaying(currentPlayer: _currentPlayer));
    await Future.delayed(gameEndingDuration);
    emit(GameEnded(winner: _getPlayersUsecase.winner));
  }

  Future<void> _updateTurn() async {
    emit(GamePlaying(currentPlayer: _currentPlayer));
    if (_currentPlayer.info.isAi) await _markAi();
  }

  Future<void> _markAi() async {
    await Future.delayed(aiThinkingDuration);
    await _mark(await _pickBestUsecase(_currentPlayer.cellValue));
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
