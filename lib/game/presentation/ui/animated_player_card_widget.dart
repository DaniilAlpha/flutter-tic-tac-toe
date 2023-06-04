import "package:flutter/material.dart";
import "package:tic_tac_toe/core/presentation/my_theme.dart";
import "package:tic_tac_toe/core/presentation/space.dart";
import "package:tic_tac_toe/game/domain/entities/game/game.dart";
import "package:tic_tac_toe/game/presentation/ui/mark_widget.dart";

class AnimatedPlayerCardWidget extends StatefulWidget {
  const AnimatedPlayerCardWidget(this.playerData,
      {required this.text, super.key});

  static const transitionDuration = Duration(milliseconds: 75);

  final Player? playerData;
  final String text;

  @override
  State<AnimatedPlayerCardWidget> createState() =>
      _AnimatedPlayerCardWidgetState();
}

class _AnimatedPlayerCardWidgetState extends State<AnimatedPlayerCardWidget> {
  var key = UniqueKey();

  @override
  void didUpdateWidget(covariant AnimatedPlayerCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.playerData != widget.playerData) key = UniqueKey();
  }

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: AnimatedPlayerCardWidget.transitionDuration,
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: Card(
          key: key,
          child: Padding(
            padding: MyTheme.cardPadding,
            child: Column(
              children: [
                if (widget.playerData != null) ...[
                  SizedBox(
                    width: IconTheme.of(context).size,
                    child: MarkWidget(widget.playerData!.cellValue),
                  ),
                  const Space.big(),
                ],
                Text(widget.text, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
}
