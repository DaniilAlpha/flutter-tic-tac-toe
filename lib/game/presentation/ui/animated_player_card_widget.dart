import "package:flutter/material.dart";
import "package:tic_tac_toe/core/presentation/my_theme.dart";
import "package:tic_tac_toe/core/presentation/space.dart";
import "package:tic_tac_toe/game/domain/entities/game/game.dart";
import "package:tic_tac_toe/game/presentation/ui/mark_widget.dart";

class AnimatedPlayerCardWidget extends StatelessWidget {
  const AnimatedPlayerCardWidget(this.playerData,
      {required this.text, super.key});

  final Player? playerData;
  final String text;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: MyTheme.cardPadding,
          child: Column(
            children: [
              if (playerData != null) ...[
                SizedBox(
                  width: IconTheme.of(context).size,
                  child: MarkWidget(playerData!.cellValue),
                ),
                const Space.big(),
              ],
              Text(text, textAlign: TextAlign.center),
            ],
          ),
        ),
      );
}
