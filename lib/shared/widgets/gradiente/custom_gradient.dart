import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {
  final double? bottom;
  final double? top;
  final double? left;
  final double? right;
  final double? height;
  final double? width;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const CustomGradient({
    super.key,
    this.bottom,
    this.top,
    this.left,
    this.right,
    this.height,
    this.width,
    required this.begin,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: bottom,
        top: top,
        left: left,
        right: right,
        child: Container(
          height: height,
          width: width, //10
          // color: Colors.amberAccent,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin,
                  end: end,
                  stops: const [0.0, 1],
                  colors: const [Colors.black, Colors.transparent])),
        ));
  }
}
