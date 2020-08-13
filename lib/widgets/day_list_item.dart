import 'package:flutter/material.dart';
import 'package:movie_time_selection/providers/day_time_provider.dart';
import 'package:movie_time_selection/themes/app_theme.dart';
import 'package:provider/provider.dart';

class DayListItem extends StatefulWidget {
  final DateTime date;
  final bool isToday;
  final bool isSelected;

  const DayListItem({
    Key key,
    @required this.date,
    this.isToday = false,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _DayListItemState createState() => _DayListItemState();
}

class _DayListItemState extends State<DayListItem>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addListener(() => setState(() {}));

    if (widget.isSelected) controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DayListItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected)
        controller.forward(from: 0.0);
      else
        controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4.0),
            onTap: widget.isSelected
                ? null
                : () {
                    Provider.of<DayTimeProvider>(
                      context,
                      listen: false,
                    ).updateDay(widget.date);
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              width: 80.0,
              child: Text(
                widget.isToday ? 'Today' : widget.date.dayAndDate,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.daySelectionColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // if (widget.isSelected)
        Container(
          width: 35.0 * controller.value,
          height: 1.0,
          color: AppTheme.daySelectionColor,
        ),
      ],
    );
  }
}

extension DateTimeX on DateTime {
  String get dayAndDate {
    String weekDayShort = '';
    switch (weekday) {
      case 1:
        weekDayShort = "Mon";
        break;
      case 2:
        weekDayShort = "Tue";
        break;
      case 3:
        weekDayShort = "Wed";
        break;
      case 4:
        weekDayShort = "Thu";
        break;
      case 5:
        weekDayShort = "Fri";
        break;
      case 6:
        weekDayShort = "Sat";
        break;
      case 7:
        weekDayShort = "Sun";
        break;
    }

    return '$weekDayShort $day';
  }
}
