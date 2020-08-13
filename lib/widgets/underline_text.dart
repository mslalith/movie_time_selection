import 'package:flutter/material.dart';
import 'package:movie_time_selection/themes/app_theme.dart';

class UnderlineText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color borderColor;
  final double borderThickness;

  const UnderlineText({
    Key key,
    @required this.text,
    this.textStyle = const TextStyle(
      fontSize: 48.0,
      fontFamily: 'Oswald',
      letterSpacing: -0.5,
    ),
    this.borderColor,
    this.borderThickness = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor ?? AppTheme.onAppBarColor,
            width: borderThickness,
          ),
        ),
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
