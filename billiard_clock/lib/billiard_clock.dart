import 'dart:async';
import 'dart:math';

import 'package:billiard_clock/widgets/billiard_table.dart';
import 'package:billiard_clock/widgets/solid_ball.dart';
import 'package:billiard_clock/widgets/striped_ball.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BilliardClock extends StatefulWidget {
  BilliardClock({Key key}) : super(key: key);

  @override
  _BilliardClockState createState() => _BilliardClockState();
}

class _BilliardClockState extends State<BilliardClock>
    with TickerProviderStateMixin {
  AnimationController _controller1;
  AnimationController _controller2;
  AnimationController _controller3;
  Timer _timer;
  int _minute;

  double _angle1;
  double _angle2;
  double _angle3;

  int _ballNum1;
  int _ballNum2;
  int _ballNum3;
  int nextBallNum1;
  int nextBallNum2;
  int nextBallNum3;

  int _numpos1;
  int _numpos2;
  int _numpos3;

  DateTime _dateTime = DateTime.now();

  /// Possible initial rotation of a ball
  List<double> _angles = [
    0.0,
    pi / 6,
    pi / 5,
    pi / 4,
    pi / 3,
    pi / 2.5,
    pi / 1.8,
    pi / 1.7,
    pi / 1.6,
  ];

  @override
  void initState() {
    super.initState();

    _angle1 = _angles[Random().nextInt(9)];
    _angle2 = _angles[Random().nextInt(9)];
    _angle3 = _angles[Random().nextInt(9)];

    _ballNum1 = 0;
    _ballNum2 = 0;
    _ballNum3 = 0;

    _numpos1 = Random().nextInt(8);
    _numpos2 = Random().nextInt(8);
    _numpos3 = Random().nextInt(8);

    _controller1 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _controller2 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _controller3 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    _dateTime = DateTime.now();

    _ballNum1 = int.parse(DateFormat('hh').format(_dateTime).toString());
    _minute = int.parse(DateFormat('mm').format(_dateTime).toString());

    if (_minute < 10) {
      _ballNum2 = 0;
      _ballNum3 = int.parse(_minute.toString().substring(0));
    } else {
      _ballNum2 = int.parse(_minute.toString().substring(0, 1));
      _ballNum3 = int.parse(_minute.toString().substring(1));
    }

    _updateTime(isInit: true);
  }

  void _updateTime({isInit = false}) {
    setState(() {
      if (!isInit) {
        _dateTime = DateTime.now();

        nextBallNum1 = int.parse(DateFormat('hh').format(_dateTime).toString());
        _minute = int.parse(DateFormat('mm').format(_dateTime).toString());

        if (_minute < 10) {
          nextBallNum2 = 0;
          nextBallNum3 = int.parse(_minute.toString().substring(0));
        } else {
          nextBallNum2 = int.parse(_minute.toString().substring(0, 1));
          nextBallNum3 = int.parse(_minute.toString().substring(1));
        }
        _playAnimation();
      }
      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        // Duration(seconds: 1),
        _updateTime,
      );
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await checkStart();
      setState(() {
        updateAngle();

        updateLabelPosition();
      });
      await checkReverse();
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  ///
  /// Check which ball(s) to animate forward
  ///
  checkStart() async {
    int index;

    if (nextBallNum3 == 0 && nextBallNum2 == 0) {
      index = 3;
    } else if (nextBallNum3 == 0 && nextBallNum2 > 0) {
      index = 2;
    } else {
      index = 1;
    }

    switch (index) {
      case 1:
        await _controller3.forward();
        break;
      case 2:
        _controller3.forward();
        await _controller2.forward();
        break;
      case 3:
        _controller3.forward();
        _controller2.forward();
        await _controller1.forward();
        break;
    }
  }

  ///
  /// Check which ball(s) to animate in reverse
  checkReverse() async {
    int index;

    if (nextBallNum3 == 0 && nextBallNum2 == 0) {
      index = 3;
    } else if (nextBallNum3 == 0 && nextBallNum2 > 0) {
      index = 2;
    } else {
      index = 1;
    }

    _ballNum1 = nextBallNum1;
    _ballNum2 = nextBallNum2;
    _ballNum3 = nextBallNum3;

    switch (index) {
      case 1:
        await _controller3.reverse();
        break;
      case 2:
        _controller3.reverse();
        await _controller2.reverse();
        break;
      case 3:
        _controller3.reverse();
        _controller2.reverse();
        await _controller1.reverse();
        break;
    }
  }

  ///
  /// Update a new angle for new ball(s) appearing
  ///
  updateAngle() {
    int index;
    if (nextBallNum3 == 0 && nextBallNum2 == 0) {
      index = 3;
    } else if (nextBallNum3 == 0 && nextBallNum2 > 0) {
      index = 2;
    } else {
      index = 1;
    }

    switch (index) {
      case 1:
        _angle3 = _angles[Random().nextInt(9)];
        break;
      case 2:
        _angle3 = _angles[Random().nextInt(9)];
        _angle2 = _angles[Random().nextInt(9)];
        break;
      case 3:
        _angle3 = _angles[Random().nextInt(9)];
        _angle2 = _angles[Random().nextInt(9)];
        _angle1 = _angles[Random().nextInt(9)];
        break;
    }
  }

  ///
  /// Update the number possition on the ball(s)
  ///
  updateLabelPosition() {
    int index;
    if (nextBallNum3 == 0 && nextBallNum2 == 0) {
      index = 3;
    } else if (nextBallNum3 == 0 && nextBallNum2 > 0) {
      index = 2;
    } else {
      index = 1;
    }

    switch (index) {
      case 1:
        _numpos3 = Random().nextInt(8);
        break;
      case 2:
        _numpos2 = Random().nextInt(8);
        _numpos3 = Random().nextInt(8);
        break;
      case 3:
        _numpos1 = Random().nextInt(8);
        _numpos2 = Random().nextInt(8);
        _numpos3 = Random().nextInt(8);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    double deviceWidth = MediaQuery.of(context).size.width;
    double tableHeight = MediaQuery.of(context).size.shortestSide;
    timeDilation = 1.0; // 1.0 is normal animation speed.
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Container(
          height: tableHeight,
          child: Stack(children: <Widget>[
            BilliardTable(),
            _ballNum1 < 9
                ? SolidBall(
                    controller: _controller1.view,
                    initLeft: deviceWidth * 0.03,
                    deviceWidth: deviceWidth,
                    tableHeight: tableHeight,
                    ballSize: deviceWidth * 0.3,
                    ballnum: _ballNum1,
                    angle: _angle1,
                    numpos: _numpos1,
                  )
                : StripedBall(
                    controller: _controller1.view,
                    initLeft: deviceWidth * 0.03,
                    deviceWidth: deviceWidth,
                    tableHeight: tableHeight,
                    ballSize: deviceWidth * 0.3,
                    ballnum: _ballNum1,
                    angle: _angle1,
                    numpos: _numpos1,
                  ),
            _ballNum2 < 9
                ? SolidBall(
                    controller: _controller2.view,
                    initLeft: deviceWidth * 0.35,
                    deviceWidth: deviceWidth,
                    tableHeight: tableHeight,
                    ballSize: deviceWidth * 0.3,
                    ballnum: _ballNum2,
                    angle: _angle2,
                    numpos: _numpos2,
                  )
                : StripedBall(
                    controller: _controller2.view,
                    initLeft: deviceWidth * 0.35,
                    deviceWidth: deviceWidth,
                    tableHeight: tableHeight,
                    ballSize: deviceWidth * 0.3,
                    ballnum: _ballNum2,
                    angle: _angle2,
                    numpos: _numpos2,
                  ),
            _ballNum3 < 9
                ? SolidBall(
                    controller: _controller3.view,
                    initLeft: deviceWidth * 0.67,
                    deviceWidth: deviceWidth,
                    tableHeight: tableHeight,
                    ballSize: deviceWidth * 0.3,
                    ballnum: _ballNum3,
                    angle: _angle3,
                    numpos: _numpos3,
                  )
                : StripedBall(
                    controller: _controller3.view,
                    initLeft: deviceWidth * 0.67,
                    deviceWidth: deviceWidth,
                    tableHeight: tableHeight,
                    ballSize: deviceWidth * 0.3,
                    ballnum: _ballNum3,
                    angle: _angle3,
                    numpos: _numpos3,
                  ),
          ]),
        ),
      ),
    );
  }
}