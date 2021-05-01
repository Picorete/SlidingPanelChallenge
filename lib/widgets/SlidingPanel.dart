import 'package:flutter/material.dart';

class SlidingPanel extends StatefulWidget {
  final Widget openendContent;
  final Widget closedContent;
  final Gradient gradientOpenedContent;
  final Color colorClosedContent;
  final Color colorOpenedContent;

  const SlidingPanel({
    required this.openendContent,
    required this.closedContent,
    this.gradientOpenedContent =
        const LinearGradient(colors: [Colors.white, Colors.white]),
    this.colorClosedContent = const Color(0xFF5732ff),
    this.colorOpenedContent = const Color(0xFF5732ff),
  }) : super();

  @override
  _SlidingPanelState createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel>
    with TickerProviderStateMixin {
  GlobalKey stickyKey = GlobalKey();

  bool opened = false;
  double heightUpdater = 1;
  double widthUpdater = 0;
  double marginUpdater = 0;
  double borderUpdater = 0;
  double opacityUpdater = 1;
  double scaleUpdater = 1;
  late double screenWidth;
  late double screenHeight;
  late Animation _animation;
  late AnimationController _controller;

  @override
  void initState() {
    // Para la escala, cuando se abre el panel
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.screenWidth = MediaQuery.of(context).size.width;
    this.screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onVerticalDragEnd: (_) {
        if (heightUpdater > screenHeight * .3) {
          setState(() {
            this.opened = false;
            heightUpdater = 0;
            widthUpdater = 0;
            marginUpdater = 0;
            borderUpdater = 0;
            opacityUpdater = 1;
            scaleUpdater = 1;
          });
        } else {
          setState(() {
            heightUpdater = 0;
            widthUpdater = 0;
            marginUpdater = 0;
            borderUpdater = 0;
            opacityUpdater = 1;
            scaleUpdater = 1;
          });
        }
      },
      onVerticalDragUpdate: (this.opened)
          ? (DragUpdateDetails dragDownDetails) {
              setState(() {
                opacityUpdater =
                    (((dragDownDetails.localPosition.dy - 250) / 250) * -1)
                        .clamp(0.0, .9);
                scaleUpdater =
                    (((dragDownDetails.localPosition.dy - 250) / 250) * -1)
                        .clamp(0.0, .9);
                heightUpdater = dragDownDetails.localPosition.dy
                    .clamp(0.0, screenHeight * .5);
                widthUpdater =
                    dragDownDetails.localPosition.dy.clamp(0.0, 30.0);
                marginUpdater =
                    dragDownDetails.localPosition.dy.clamp(0.0, 15.0);
                borderUpdater =
                    dragDownDetails.localPosition.dy.clamp(0.0, 15.0);
              });
            }
          : null,
      onTap: (opened)
          ? null
          : () => setState(() {
                _controller.reset();
                this.opened = true;
                _controller.forward();
              }),
      child: AnimatedContainer(
        key: stickyKey,
        child: Column(
          children: [
            (this.opened)
                ? Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[100]?.withOpacity(.3)),
                  )
                : Container(),
            Expanded(
              child: (this.opened)
                  ? Transform.scale(
                      scale: _animation.value,
                      child: Opacity(
                        opacity: this.opacityUpdater,
                        child: widget.openendContent,
                      ),
                    )
                  : Container(
                      width: screenWidth * .5,
                      child: widget.closedContent,
                    ),
            ),
          ],
        ),
        margin: (this.opened)
            ? EdgeInsets.only(bottom: marginUpdater)
            : EdgeInsets.only(bottom: 10),
        duration: Duration(milliseconds: 200),
        curve: Curves.decelerate,
        width: (this.opened) ? screenWidth - widthUpdater : screenWidth * .5,
        height: (this.opened)
            ? (screenHeight * .6 - heightUpdater)
            : screenHeight * .13,
        decoration: BoxDecoration(
            gradient: (this.opened) ? widget.gradientOpenedContent : null,
            borderRadius: (this.opened)
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(borderUpdater),
                    bottomRight: Radius.circular(borderUpdater))
                : BorderRadius.circular(20),
            color: (this.opened)
                ? widget.colorOpenedContent
                : widget.colorClosedContent),
      ),
    );
  }
}
