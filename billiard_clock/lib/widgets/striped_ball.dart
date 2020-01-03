import 'dart:math';

import 'package:billiard_clock/widgets/ball_gradient.dart';
import 'package:billiard_clock/widgets/ball_highilght_bottom.dart';
import 'package:billiard_clock/widgets/ball_highilght_top.dart';
import 'package:billiard_clock/widgets/ball_shadow.dart';
import 'package:flutter/material.dart';

class StripedBall extends StatelessWidget {
  StripedBall(
      {Key key,
      this.controller,
      this.ballSize = 200,
      this.initLeft = 30,
      this.tableHeight = 400,
      this.deviceWidth = 600,
      this.angle = 0,
      this.numpos = 1,
      this.ballnum = 0})
      : left = Tween<double>(
          begin: initLeft,
          end: initLeft + deviceWidth,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0,
              1,
              curve: Curves.linear,
            ),
          ),
        ),
        rotate = Tween<double>(
          begin: 0,
          end: 2 * pi,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0,
              1,
              curve: Curves.linear,
            ),
          ),
        ),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> left;
  final Animation<double> rotate;
  final double ballSize;
  final double initLeft;
  final double deviceWidth;
  final double tableHeight;
  final double angle;

  final int ballnum;
  final int numpos;

  Widget _buildAnimation(BuildContext context, Widget child) {
    Color color = Colors.yellow[700];
    switch (ballnum) {
      case 10:
        color = Colors.blue[700];
        break;
      case 11:
        color = Colors.red[700];
        break;
      case 12:
        color = Colors.purple[700];
        break;
    }

    return Positioned(
      top: (tableHeight / 2) - (ballSize / 1.5),
      left: left.value,
      child: Stack(
        children: <Widget>[
          BallShadow(
            ballSize: ballSize,
          ),
          Transform.rotate(
            angle: angle,
            child: Stack(
              children: <Widget>[
                Transform.rotate(
                  angle: rotate.value,
                  child: ClipOval(
                    child: Container(
                      width: ballSize,
                      height: ballSize,
                      color: Color.fromRGBO(250, 250, 250, 1),
                      alignment: Alignment.center,
                      child: new Container(
                        width: ballSize,
                        height: ballSize / 2,
                        alignment: Alignment.center,
                        color: color,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: ballSize,
                  height: ballSize,
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: rotate.value,
                    child: Container(
                      width: ballSize * 0.4,
                      height: ballSize * 0.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      transform: Matrix4.rotationY(pi /
                          [.01, 7.5, 8.5, 9.5, 10.5, 6.5, 7.5, 8.5][numpos]),
                      child: Text(
                        '$ballnum',
                        style: TextStyle(
                          fontSize: ballSize * 0.29,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -6,
                          decoration: ballnum == 9
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BallGradient(
            ballSize: ballSize,
          ),
          HighlightTop(
            ballSize: ballSize,
          ),
          HighlightBottom(
            ballSize: ballSize,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
