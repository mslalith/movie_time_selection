import 'package:flutter/material.dart';
import 'package:movie_time_selection/providers/day_time_provider.dart';
import 'package:movie_time_selection/themes/app_theme.dart';
import 'package:movie_time_selection/widgets/day_list_item.dart';
import 'package:movie_time_selection/extensions.dart';
import 'package:provider/provider.dart';

class DayTimeList extends StatelessWidget {
  final double scrollPercent;

  const DayTimeList({
    Key key,
    @required this.scrollPercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: Offset(0.0, -0.5 * scrollPercent),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.0 * scrollPercent,
        ),
        decoration: BoxDecoration(
          color: AppTheme.daySelectionBackgroundColor,
          borderRadius: BorderRadius.circular(10.0 * scrollPercent),
        ),
        child: Material(
          elevation: 16.0 * scrollPercent,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0 * scrollPercent),
          ),
          child: Selector<DayTimeProvider, DateTime>(
            selector: (_, provider) => provider.day,
            builder: (_, day, child) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 33.0),
                itemCount: 12,
                itemBuilder: (_, index) {
                  final date = DateTime.now().add(Duration(days: index));
                  return DayListItem(
                    date: date,
                    isToday: index == 0,
                    isSelected: date.isDateEqualTo(day),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
