import 'package:flutter/material.dart';
import 'package:movie_time_selection/themes/app_theme.dart';
import 'package:movie_time_selection/widgets/app_bar_content_text.dart';
import 'package:movie_time_selection/widgets/back_arrow_button.dart';
import 'package:movie_time_selection/widgets/day_time_list.dart';
import 'package:movie_time_selection/widgets/day_time_month_text.dart';

class AnimatedAppBar extends StatelessWidget {
  final double minAppBarHeight;
  final double maxAppBarHeight;

  const AnimatedAppBar({
    Key key,
    @required this.minAppBarHeight,
    @required this.maxAppBarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _AnimatedAppBarDelegate(
        minAppBarHeight: minAppBarHeight,
        maxAppBarHeight: maxAppBarHeight,
      ),
    );
  }
}

class _AnimatedAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minAppBarHeight;
  final double maxAppBarHeight;
  final double minDayTimeHeight;
  final double maxDayTimeHeight;
  Tween<double> appBarTextTween;
  Tween<double> dayTimeListTween;
  Tween<double> dayTimeMonthTween;

  _AnimatedAppBarDelegate({
    @required this.minAppBarHeight,
    @required this.maxAppBarHeight,
    this.minDayTimeHeight = kToolbarHeight,
    this.maxDayTimeHeight = kToolbarHeight * 3,
  }) {
    final totalMinHeight = minAppBarHeight + minDayTimeHeight;
    final totalMaxHeight = maxAppBarHeight + maxDayTimeHeight;
    appBarTextTween = Tween<double>(
      begin: totalMaxHeight - maxAppBarHeight,
      end: totalMaxHeight,
    );
    dayTimeListTween = Tween<double>(
      begin: maxAppBarHeight,
      end: totalMinHeight,
    );
    dayTimeMonthTween = Tween<double>(
      begin: maxAppBarHeight,
      end: (minDayTimeHeight * 0.5) - (kToolbarHeight * 0.25),
    );
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double scrollPercent = shrinkOffset / (maxExtent - minExtent);
    scrollPercent = scrollPercent.clamp(0.0, 1.0);
    return Container(
      color: AppTheme.appBarColor,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(
            top: minDayTimeHeight * 0.5,
            left: 28.0,
            child: BackArrow(),
          ),
          Positioned(
            top: -maxAppBarHeight * scrollPercent * 3.5,
            right: 0.0,
            child: Image.asset('images/vr_face.png'),
          ),
          Positioned(
            bottom: 16.0 + appBarTextTween.transform(scrollPercent),
            left: 45.0,
            child: AppBarContentText(),
          ),
          Positioned(
            top: dayTimeListTween.transform(scrollPercent),
            height:
                kToolbarHeight + (kToolbarHeight * 2 * (1.0 - scrollPercent)),
            left: 0.0,
            right: 0.0,
            child: DayTimeList(scrollPercent: scrollPercent),
          ),
          Positioned(
            top: dayTimeMonthTween.transform(scrollPercent),
            height: kToolbarHeight,
            left: 30.0 * scrollPercent,
            right: 0.0,
            child: DayTimeMonthText(scrollPercent: scrollPercent),
          ),
        ],
      ),
    );
  }

  @override
  double get minExtent => minAppBarHeight + minDayTimeHeight;

  @override
  double get maxExtent => maxAppBarHeight + maxDayTimeHeight;

  @override
  bool shouldRebuild(_AnimatedAppBarDelegate oldDelegate) {
    return oldDelegate.minAppBarHeight != minAppBarHeight &&
        oldDelegate.maxAppBarHeight != maxAppBarHeight;
  }
}
