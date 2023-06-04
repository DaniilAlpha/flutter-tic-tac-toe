import "package:flutter/material.dart";
import "package:tic_tac_toe/core/presentation/my_theme.dart";

class ScrollablePage extends StatelessWidget {
  const ScrollablePage(
      {required this.child, this.alignment = Alignment.center, super.key});

  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) => Align(
        alignment: alignment,
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Align(
              alignment: alignment,
              child: SizedBox(
                width: MyTheme.pageMaxWidth,
                child: child,
              ),
            ),
          ),
        ),
      );
}
