import 'package:flutter/material.dart';

class AnimatedBar extends StatefulWidget {
  final double targetWidth;
  final Color color;
  final Duration duration;

  const AnimatedBar({
    super.key,
    required this.targetWidth,
    required this.color,
    this.duration = const Duration(seconds: 3),
  });
  @override
  State<AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar> {
  double width = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        width = widget.targetWidth;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: 4,
      color: widget.color,
      duration: widget.duration,
      curve: Curves.fastOutSlowIn,
    );
  }
}