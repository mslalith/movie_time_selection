import 'package:flutter/material.dart';
import 'package:movie_time_selection/providers/scroll_provider.dart';
import 'package:movie_time_selection/themes/app_theme.dart';
import 'package:movie_time_selection/widgets/app_bar_content_text.dart';
import 'package:movie_time_selection/widgets/back_arrow_button.dart';
import 'package:movie_time_selection/widgets/day_time_list.dart';
import 'package:movie_time_selection/widgets/day_time_month_text.dart';
import 'package:movie_time_selection/widgets/timings_grid.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final screenSize = Size(
          constraints.maxWidth,
          constraints.maxHeight,
        );

        final screenLeft =
            (MediaQuery.of(context).size.width - screenSize.width) / 2;
        final screenTop =
            (MediaQuery.of(context).size.height - screenSize.height) / 2;

        final screenRect = Rect.fromLTWH(
          screenLeft,
          screenTop,
          screenSize.width,
          screenSize.height,
        );

        final screenHeight = screenRect.height;
        final maxAppBarHeight = screenHeight * 0.4;
        final minAppBarHeight = maxAppBarHeight * 0.5;
        final minDayTimeHeight = kToolbarHeight;
        final maxDayTimeHeight = kToolbarHeight * 3;

        final totalMinHeight = minAppBarHeight + minDayTimeHeight;
        final totalMaxHeight = maxAppBarHeight + maxDayTimeHeight;

        final appBarHeightTween = Tween<double>(
          begin: totalMaxHeight,
          end: totalMinHeight,
        );
        final gridTopTween = Tween<double>(
          begin: totalMaxHeight - (kToolbarHeight * 0.75),
          end: totalMinHeight,
        );
        final appBarTextTween = Tween<double>(
          begin: screenHeight - maxAppBarHeight,
          end: screenHeight * 1.5,
        );
        final dayTimeListTween = Tween<double>(
          begin: maxAppBarHeight,
          end: totalMinHeight,
        );
        final dayTimeMonthTween = Tween<double>(
          begin: maxAppBarHeight,
          end: (minDayTimeHeight * 0.5) - (kToolbarHeight * 0.25),
        );

        return Consumer<ScrollProvider>(
          builder: (_, provider, child) {
            final gridScrollOffset = 0.2;
            double scrollPercent = provider.scrollOffset;
            scrollPercent /= (screenHeight - totalMaxHeight);
            scrollPercent = scrollPercent.clamp(0.0, 1.0);

            return Container(
              height: screenHeight,
              child: Stack(
                children: [
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: appBarHeightTween.transform(scrollPercent),
                      color: AppTheme.appBarColor,
                    ),
                  ),
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
                    height: kToolbarHeight +
                        (kToolbarHeight * 2 * (1.0 - scrollPercent)),
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
                  Positioned(
                    top: gridTopTween.transform(scrollPercent < gridScrollOffset
                        ? 0.0
                        : (scrollPercent - gridScrollOffset) /
                            (1.0 - gridScrollOffset)),
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: TimingsGrid(
                      screenRect: screenRect,
                      scrollPercent: scrollPercent,
                    ),
                  ),
                  if (scrollPercent > 0.35)
                    Positioned(
                      top: dayTimeListTween.transform(scrollPercent),
                      height: kToolbarHeight +
                          (kToolbarHeight * 2 * (1.0 - scrollPercent)),
                      left: 0.0,
                      right: 0.0,
                      child: DayTimeList(scrollPercent: scrollPercent),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
