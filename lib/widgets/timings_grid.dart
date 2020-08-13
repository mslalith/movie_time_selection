import 'package:flutter/material.dart';
import 'package:movie_time_selection/extensions.dart';
import 'package:movie_time_selection/models/timing.dart';
import 'package:movie_time_selection/providers/day_time_provider.dart';
import 'package:movie_time_selection/providers/scroll_provider.dart';
import 'package:movie_time_selection/widgets/overlay_time_grid_item.dart';
import 'package:movie_time_selection/widgets/sized_grid.dart';
import 'package:provider/provider.dart';

class TimingsGrid extends StatefulWidget {
  final Rect screenRect;
  final double scrollPercent;

  const TimingsGrid({
    Key key,
    @required this.screenRect,
    @required this.scrollPercent,
  }) : super(key: key);

  @override
  _TimingsGridState createState() => _TimingsGridState();
}

class _TimingsGridState extends State<TimingsGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 36.0 * (1.0 - widget.scrollPercent),
      ),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0 * (1.0 - widget.scrollPercent)),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0 * (1.0 - widget.scrollPercent)),
        ),
        child: Selector<DayTimeProvider, DateTime>(
          selector: (_, provider) => provider.time,
          builder: (_, time, child) {
            return SizedGrid(
              builder: (double gridWidth, double gridHeight) {
                final gridRect = Rect.fromLTWH(
                  widget.screenRect.left +
                      (widget.screenRect.width - gridWidth) / 2,
                  widget.screenRect.top + widget.screenRect.height - gridHeight,
                  gridWidth,
                  gridHeight,
                );
                return _grid(gridRect, time);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _grid(Rect gridRect, DateTime time) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 0.5,
        crossAxisSpacing: 0.5,
      ),
      controller: Provider.of<ScrollProvider>(
        context,
        listen: false,
      ).controller,
      shrinkWrap: true,
      itemCount: timings.length,
      itemBuilder: (_, index) {
        final timing = timings[index];
        return OverlayTimeGridItem(
          screenRect: widget.screenRect,
          gridRect: gridRect,
          timing: timing,
          isSelected: time.isTimeEqualTo(timing.time),
        );
      },
    );
  }
}
