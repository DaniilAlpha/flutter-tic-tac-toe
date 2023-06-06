import "package:flutter/material.dart";
import "package:tic_tac_toe/core/domain/math.dart";
import "package:tic_tac_toe/core/presentation/my_theme.dart";
import "package:tic_tac_toe/game/domain/entities/field/field.dart";
import "package:tic_tac_toe/game/presentation/ui/complete_line_widget.dart";
import "package:tic_tac_toe/game/presentation/ui/mark_widget.dart";

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    required this.field,
    required this.onCellPressed,
    super.key,
  });

  final Field field;
  final void Function(FieldPos pos) onCellPressed;

  Widget _constructGrid() => Stack(children: [
        for (var i = 1; i < field.height; i++)
          Align(
            alignment: Alignment(0, (i / field.height) * 2 - 1),
            child: const Divider(),
          ),
        for (var i = 1; i < field.width; i++)
          Align(
            alignment: Alignment((i / field.width) * 2 - 1, 0),
            child: const VerticalDivider(),
          ),
      ]);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenDimension = min(screenSize.width, screenSize.height) * .75;
    final dimension = min(MyTheme.pageMaxWidth, screenDimension);
    final lineWidth = dimension / min(field.width, field.height) / 20;
    return SizedBox(
      height: dimension,
      width: dimension,
      child: Center(
        child: AspectRatio(
          aspectRatio: field.width / field.height,
          child: DividerTheme(
            data: DividerThemeData(space: lineWidth, thickness: lineWidth),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _constructGrid(),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: field.width,
                  children: [
                    for (var y = 0; y < field.height; y++)
                      for (var x = 0; x < field.width; x++)
                        InkWell(
                          onTap: () => onCellPressed(FieldPos(x, y)),
                          child: AnimatedMarkWidget(field.at(FieldPos(x, y))),
                        ),
                  ],
                ),
                CompleteLineWidget(
                  line: field.lineFullOf(CellValue.X),
                  color: Colors.red,
                ),
                CompleteLineWidget(
                  line: field.lineFullOf(CellValue.O),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
