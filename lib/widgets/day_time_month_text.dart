import 'package:flutter/material.dart';
import 'package:movie_time_selection/themes/app_theme.dart';

class DayTimeMonthText extends StatelessWidget {
  final double scrollPercent;

  const DayTimeMonthText({
    Key key,
    @required this.scrollPercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(-1.0, 0.5 * (1.0 - scrollPercent)),
      margin: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Text(
        'December',
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: ColorTween(
                begin: AppTheme.daySelectionColor,
                end: AppTheme.onAppBarColor,
              ).transform(scrollPercent * 3),
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
