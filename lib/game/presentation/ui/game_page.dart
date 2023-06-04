import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tic_tac_toe/core/presentation/scrollable_page.dart";
import "package:tic_tac_toe/core/presentation/space.dart";
import "package:tic_tac_toe/game/domain/entities/field/field.dart";
import "package:tic_tac_toe/game/presentation/bloc/game_cubit.dart";
import "package:tic_tac_toe/game/presentation/ui/animated_player_card_widget.dart";
import "package:tic_tac_toe/game/presentation/ui/field_widget.dart";

class GamePage extends StatefulWidget {
  const GamePage({required this.field, super.key});

  final Field field;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const transitionDuration = Duration(milliseconds: 300);

  late final cubit = context.read<GameCubit>();

  Field get field => widget.field;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Tic Tac Toe")),
        body: ScrollablePage(
          child: BlocBuilder<GameCubit, GameState>(
            builder: (_, state) {
              final key = ValueKey(state.runtimeType);
              final Widget page = switch (state) {
                GamePlaying() => Column(
                    key: key,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedPlayerCardWidget(
                        state.currentPlayer,
                        text: "${state.currentPlayer.info.name}"
                            "${state.currentPlayer.info.name.endsWith("s") ? "es" : "'s"}"
                            " turn!",
                      ),
                      const Space.big(),
                      FieldWidget(
                        field: field,
                        onCellPressed: cubit.mark,
                      ),
                    ],
                  ),
                GameEnded() => Column(
                    key: key,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedPlayerCardWidget(
                        state.winner,
                        text: state.winner == null
                            ? "Draw!"
                            : "${state.winner!.info.name} wins!"
                                "\n"
                                "Already won ${state.winner!.score} time"
                                "${state.winner!.score == 1 ? "" : "s"}"
                                ".",
                      ),
                      const Space.small(),
                      ElevatedButton(
                        onPressed: cubit.restart,
                        child: const Text("RESTART"),
                      ),
                    ],
                  )
              };

              return AnimatedSize(
                duration: transitionDuration,
                child: AnimatedSwitcher(
                  duration: transitionDuration,
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInExpo,
                  child: page,
                ),
              );
            },
          ),
        ),
      );
}
