import 'package:flutter/material.dart';

class BallGradient extends StatelessWidget {
  const BallGradient({
    Key key,
    this.ballSize = 200,
  }) : super(key: key);

  final double ballSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ballSize,
      height: ballSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFE6E6E6),
            Color(0xFFBEBEBE),
            Color(0xFF141414)
          ],
          stops: [0.1, 0.2, 0.5, 1],
          radius: 1.1,
          center: Alignment(
            -0.5,
            -0.5,
          ),
        ),
        backgroundBlendMode: BlendMode.modulate,
      ),
    );
  }
}
