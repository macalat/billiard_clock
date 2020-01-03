import 'package:flutter/material.dart';

class HighlightBottom extends StatelessWidget {
  const HighlightBottom({
    Key key,
    this.ballSize = 200,
  }) : super(key: key);

  final double ballSize;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HighlightBottomClipper(unit: ballSize / 100),
      child: Container(
        width: ballSize,
        height: ballSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, .5),
              Color.fromRGBO(255, 255, 255, 0),
            ],
          ),
        ),
      ),
    );
  }
}

class HighlightBottomClipper extends CustomClipper<Path> {
  double unit;

  HighlightBottomClipper({this.unit});
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(unit * 66, unit * 93)
      ..quadraticBezierTo(unit * 87, unit * 82, unit * 94, unit * 60)
      ..quadraticBezierTo(unit * 82, unit * 79, unit * 66, unit * 93);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
