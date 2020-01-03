import 'package:flutter/material.dart';

class BallShadow extends StatelessWidget {
  const BallShadow({
    Key key,
    this.ballSize = 200,
  }) : super(key: key);

  final double ballSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      transform: Matrix4.diagonal3Values(1, .2, 3),
      margin: EdgeInsets.only(top: ballSize / .22, left: ballSize / 2.5),
      width: ballSize / 2,
      height: ballSize / 2,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xff101010),
            blurRadius: 20.0,
            spreadRadius: 5.0,
          )
        ],
      ),
    );
  }
}
