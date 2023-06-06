import "package:flutter/material.dart";
import "package:tic_tac_toe/core/domain/ui.dart";
import "package:tic_tac_toe/core/presentation/empty_widget.dart";
import "package:tic_tac_toe/game/domain/entities/field/field.dart";

class CompleteLineWidget extends StatefulWidget {
  const CompleteLineWidget({
    required this.line,
    this.color = Colors.black,
    super.key,
  });

  final FieldLineIterable? line;
  final Color color;

  @override
  State<CompleteLineWidget> createState() => _CompleteLineWidgetState();
}

class _CompleteLineWidgetState extends State<CompleteLineWidget>
    with SingleTickerProviderStateMixin {
  static const animationDuration = Duration(milliseconds: 400);
  static const animationCurve = Curves.easeOutQuint;

  late final animationController =
      AnimationController(duration: animationDuration, vsync: this)
        ..forward()
        ..addListener(() => setState(() {}));
  late final animation =
      CurvedAnimation(curve: animationCurve, parent: animationController);

  CompleteLinePainterData? data;

  @override
  void didUpdateWidget(covariant CompleteLineWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.line == null || oldWidget.line == widget.line) return;

    final line = widget.line!;
    final start = 0.2, endW = line.width - start, endH = line.height - start;

    data = CompleteLinePainterData(
        lineWidth: line.width,
        points: switch (line) {
          FieldAxisIterable(isRow: final isRow, n: final n) => isRow
              ? (Offset(start, n + 0.5), Offset(endW, n + 0.5))
              : (Offset(n + 0.5, start), Offset(n + 0.5, endH)),
          FieldDiagonalIterable(
            isStraight: final isLtR,
            isHorizontal: final isHorizontal,
            n: final n,
          ) =>
            isHorizontal
                ? (
                    Offset((isLtR ? start : endH) + n, start),
                    Offset((isLtR ? endH : start) + n, endH),
                  )
                : (
                    Offset((isLtR ? start : endW), start + n),
                    Offset((isLtR ? endW : start), endW + n),
                  ),
        });
  }

  @override
  Widget build(BuildContext context) => data == null
      ? const EmptyWidget()
      : CustomPaint(
          painter: CompleteLinePainter(
            data: data!,
            time: animation.value,
            color: widget.color,
          ),
        );
}

class CompleteLinePainter extends CustomPainter {
  CompleteLinePainter({
    required this.data,
    required this.time,
    required Color color,
  }) : _paint = Paint()
          ..color = color
          ..strokeCap = StrokeCap.round;

  final CompleteLinePainterData data;
  final double time;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final cellDim = size.width / data.lineWidth;
    canvas.drawLine(
      data.points.$1 * cellDim,
      lerpOffset(data.points.$1, data.points.$2, time) * cellDim,
      _paint..strokeWidth = cellDim * .16,
    );
  }

  @override
  bool shouldRepaint(covariant CompleteLinePainter oldDelegate) =>
      oldDelegate.data != data || oldDelegate.time != time;
}

class CompleteLinePainterData {
  CompleteLinePainterData({
    required this.lineWidth,
    required this.points,
  });

  final int lineWidth;
  final (Offset, Offset) points;
}
