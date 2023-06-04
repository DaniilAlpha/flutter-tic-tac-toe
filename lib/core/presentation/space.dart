import "package:flutter/material.dart";
import "package:tic_tac_toe/core/presentation/my_theme.dart";

class Space extends StatelessWidget {
  const Space(this.size, {super.key});
  const Space.big({super.key}) : size = MyTheme.bigSpaceSize;
  const Space.small({super.key}) : size = MyTheme.smallSpaceSize;

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(width: size, height: size);
}
