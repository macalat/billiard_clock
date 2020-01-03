import 'dart:math';

import 'package:billiard_clock/widgets/ball_gradient.dart';
import 'package:billiard_clock/widgets/ball_highilght_bottom.dart';
import 'package:billiard_clock/widgets/ball_highilght_top.dart';
import 'package:billiard_clock/widgets/ball_shadow.dart';
import 'package:flutter/material.dart';

class SolidBall extends StatelessWidget {
  SolidBall(
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

  final solidColors = [
    Color(0xffeeeeee),
    Colors.yellow[700],
    Colors.blue[700],
    Colors.red[700],
    Colors.purple[700],
    Colors.orange[700],
    Colors.green[700],
    Colors.brown[700],
    Color(0xff252525),
  ];

  final int ballnum;
  final int numpos;

  Widget _buildAnimation(BuildContext context, Widget child) {
    var solidColor = solidColors[ballnum];
    return Positioned(
      top: (tableHeight / 2) - (ballSize / 1.5),
      left: left.value,
      child: Stack(
        children: <Widget>[
          BallShadow(
            ballSize: ballSize,
          ),
          Container(
            height: ballSize,
            width: ballSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: solidColor,
            ),
            child: Transform.rotate(
              angle: angle,
              child: Container(
                width: ballSize,
                height: ballSize,
                alignment: Alignment.center,
                child: ballnum > 0
                    ? Transform.rotate(
                        angle: rotate.value,
                        child: Container(
                          width: ballSize * 0.4,
                          height: ballSize * 0.4,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              left: [
                                0.0,
                                ballSize * 0.6,
                                ballSize * 0.45,
                                ballSize * 0.3,
                                ballSize * 0.15,
                                0.0,
                                0.0,
                                0.0
                              ][numpos],
                              right: [
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                                ballSize * 0.45,
                                ballSize * 0.3,
                                ballSize * 0.15
                              ][numpos]),
                          transform: Matrix4.rotationY(pi /
                              [
                                .01,
                                7.5,
                                8.5,
                                9.5,
                                10.5,
                                6.5,
                                7.5,
                                8.5
                              ][numpos]),
                          child: Text(
                            '$ballnum',
                            style: TextStyle(
                              fontSize: ballSize * 0.29,
                              fontWeight: FontWeight.bold,
                              decoration: ballnum == 6
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xfff1f1f1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : Container(),
              ),
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
