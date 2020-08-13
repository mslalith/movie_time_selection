import 'package:flutter/material.dart';

class AnimatedOverlayTimeGridItem extends StatefulWidget {
  final Rect screenRect;
  final Rect gridRect;
  final Rect fromRect;
  final Rect toRect;
  final double buttonMargin;
  final VoidCallback onTap;
  final Widget Function(double) animateValueBuilder;
  final Widget nextButton;

  const AnimatedOverlayTimeGridItem({
    Key key,
    @required this.screenRect,
    @required this.gridRect,
    @required this.fromRect,
    @required this.toRect,
    @required this.onTap,
    @required this.animateValueBuilder,
    @required this.nextButton,
    this.buttonMargin = 16.0,
  }) : super(key: key);

  @override
  _AnimatedOverlayTimeGridItemState createState() =>
      _AnimatedOverlayTimeGridItemState();
}

class _AnimatedOverlayTimeGridItemState
    extends State<AnimatedOverlayTimeGridItem>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  RectTween rectTween;
  Tween buttonTween;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          widget.onTap();
        }
      });

    buttonTween = Tween<double>(begin: 0.4, end: 1.0);
    rectTween = RectTween(
      begin: widget.fromRect,
      end: widget.toRect,
    );
    controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    final screenRight = (mediaSize.width - widget.screenRect.width) / 2;
    final screenBottom = (mediaSize.height - widget.screenRect.height) / 2;

    return Stack(
      children: [
        Positioned.fromRect(
          rect: rectTween.transform(controller.value),
          child: widget.animateValueBuilder(controller.value),
        ),
        Positioned.fromRect(
          rect: widget.gridRect,
          child: GestureDetector(
            onTap: controller.reverse,
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          bottom: screenBottom + widget.buttonMargin,
          right: screenRight + widget.buttonMargin,
          child: Transform.scale(
            scale: buttonTween.transform(controller.value),
            child: FadeTransition(
              opacity: controller,
              child: widget.nextButton,
            ),
          ),
        ),
      ],
    );
  }
}
