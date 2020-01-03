import 'package:flutter/material.dart';

class HighlightTop extends StatelessWidget {
  const HighlightTop({
    Key key,
    this.ballSize = 200,
  }) : super(key: key);

  final double ballSize;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HighlightTopClipper(unit: ballSize / 100),
      child: Container(
        width: ballSize,
        height: ballSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 0.5),
              Color.fromRGBO(240, 240, 240, 0.3),
              Color.fromRGBO(230, 230, 230, 0.2),
              Color.fromRGBO(230, 230, 230, 0.0),
            ],
            stops: [0.1, 0.2, 0.5, 1],
            radius: 1.1,
            center: Alignment(
              -0.7,
              -0.7,
            ),
          ),
        ),
      ),
    );
  }
}

class HighlightTopClipper extends CustomClipper<Path> {
  double unit;

  HighlightTopClipper({this.unit});
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(unit * 30, unit * 50)
      ..quadraticBezierTo(unit * 35, unit * 36, unit * 48, unit * 26)
      ..quadraticBezierTo(unit * 45, unit * 19, unit * 38, unit * 15)
      ..quadraticBezierTo(unit * 26, unit * 16, unit * 10, unit * 32)
      ..quadraticBezierTo(unit * 20, unit * 48, unit * 30, unit * 50);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
