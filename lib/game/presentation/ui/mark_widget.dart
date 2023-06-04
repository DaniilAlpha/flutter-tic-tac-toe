import "package:flutter/material.dart";
import "package:tic_tac_toe/core/presentation/empty_widget.dart";
import "package:tic_tac_toe/game/domain/entities/field/field.dart";

class MarkWidget extends StatelessWidget {
  const MarkWidget(this.cellValue, {super.key});

  final CellValue? cellValue;

  @override
  Widget build(BuildContext context) {
    switch (cellValue) {
      case CellValue.X:
        return Image.asset(
          "assets/images/cross.png",
          color: Colors.red,
        );
      case CellValue.O:
        return Image.asset(
          "assets/images/circle.png",
          color: Colors.blue,
        );
      case null:
        return const EmptyWidget();
    }
  }
}

class AnimatedMarkWidget extends StatelessWidget {
  const AnimatedMarkWidget(this.cellValue, {super.key});

  final CellValue? cellValue;

  @override
  Widget build(BuildContext context) => AnimatedScale(
        scale: cellValue == null ? 0 : .5,
        duration: const Duration(milliseconds: 500),
        curve: Curves.elasticOut,
        child: MarkWidget(cellValue),
      );
}
