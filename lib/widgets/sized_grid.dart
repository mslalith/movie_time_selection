import 'package:flutter/material.dart';

class SizedGrid extends StatelessWidget {
  final Function(double, double) builder;

  const SizedGrid({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return builder(width, height);
      },
    );
  }
}
