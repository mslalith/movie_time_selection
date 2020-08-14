import 'package:flutter/material.dart';
import 'package:movie_time_selection/extensions.dart';
import 'package:movie_time_selection/models/timing.dart';
import 'package:movie_time_selection/providers/day_time_provider.dart';
import 'package:movie_time_selection/themes/app_theme.dart';
import 'package:movie_time_selection/widgets/animated_overlay_time_grid_item.dart';
import 'package:provider/provider.dart';

class OverlayTimeGridItem extends StatefulWidget {
  final Rect screenRect;
  final Rect gridRect;
  final Timing timing;
  final bool isSelected;

  const OverlayTimeGridItem({
    Key key,
    @required this.screenRect,
    @required this.gridRect,
    @required this.timing,
    @required this.isSelected,
  }) : super(key: key);

  @override
  _OverlayTimeGridItemState createState() => _OverlayTimeGridItemState();
}

class _OverlayTimeGridItemState extends State<OverlayTimeGridItem> {
  OverlayEntry overlayEntry;
  bool isGridItemLeft = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.timing.disabled
          ? null
          : () {
              final rect = _getItemBounds(context);
              showOverlay(rect);
              _updateProviderTime(widget.timing.time);
            },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                left: BorderSide(
                  color: isGridItemLeft ? AppTheme.buttonColor : Colors.white,
                  width: 10.0,
                ),
                right: BorderSide(
                  color: isGridItemLeft ? Colors.white : AppTheme.buttonColor,
                  width: 10.0,
                ),
              ),
            ),
          ),
          if (overlayEntry == null) _gridItem(0),
        ],
      ),
    );
  }

  Widget _gridItem(double value) {
    return Material(
      elevation: 24.0 * value,
      borderRadius: BorderRadius.circular(12.0 * value),
      child: Container(
        color: widget.timing.disabled ? Colors.grey[200] : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.timing.time.timeNotation,
              style: TextStyle(
                color: AppTheme.timeTextColor,
                fontSize: 36.0,
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              '\$ ${widget.timing.price}',
              style: TextStyle(
                color: AppTheme.timeTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'per person',
              style: TextStyle(
                color: AppTheme.timeTextColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nextButton() {
    return FlatButton(
      onPressed: () {},
      color: AppTheme.buttonColor,
      child: Text(
        'Next',
        style: TextStyle(color: AppTheme.onButtonColor),
      ),
    );
  }

  void showOverlay(Rect itemRect) {
    final itemSlideOffset = itemRect.width * 0.3;
    final isLeftOrRightMultiplier =
        widget.gridRect.left == itemRect.left ? 1.0 : -1.0;
    isGridItemLeft = isLeftOrRightMultiplier == 1.0;
    final isUpOrDownMultiplier =
        (itemRect.bottom + itemSlideOffset) > widget.gridRect.bottom ? -1.0 : 1.0;
    final offsetX = itemSlideOffset * isLeftOrRightMultiplier;
    final offsetY = itemSlideOffset * isUpOrDownMultiplier;
    final overlayFromRect = Rect.fromLTWH(
      widget.gridRect.left +
          (isLeftOrRightMultiplier == 1.0 ? 0.0 : itemRect.width),
      itemRect.top,
      itemRect.width,
      itemRect.height,
    );
    final overlayToRect = Rect.fromLTWH(
      overlayFromRect.left + offsetX,
      overlayFromRect.top + offsetY,
      itemRect.width,
      itemRect.height,
    );

    overlayEntry = OverlayEntry(
      builder: (_) {
        return AnimatedOverlayTimeGridItem(
          screenRect: widget.screenRect,
          gridRect: widget.gridRect,
          fromRect: overlayFromRect,
          toRect: overlayToRect,
          animateValueBuilder: _gridItem,
          nextButton: _nextButton(),
          onTap: () {
            _updateProviderTime(DateTime(0, 0, 0));
            hideOverlay();
          },
        );
      },
    );
    Overlay.of(context).insert(overlayEntry);
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
    setState(() {});
  }

  Rect _getItemBounds(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final topLeft = box.size.topLeft(
      box.localToGlobal(Offset.zero),
    );
    final bottomRight = box.size.bottomRight(
      box.localToGlobal(Offset.zero),
    );
    final rect = Rect.fromLTRB(
      topLeft.dx,
      topLeft.dy,
      bottomRight.dx,
      bottomRight.dy,
    );
    return rect;
  }

  void _updateProviderTime(DateTime time) {
    Provider.of<DayTimeProvider>(
      context,
      listen: false,
    ).updateTime(time);
  }
}
