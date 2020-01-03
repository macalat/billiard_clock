import 'package:flutter/material.dart';

class BilliardTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.transparent,
              Color(0xFF433E1E),
              Color(0xFF433E1E),
              Color(0xFF3CAD3B),
              Color(0xFF60C460),
              Color(0xFF027837),
              Color(0xFF165030),
              Color(0xFF20A726),
              Color(0xFF3CAD3B),
              Color(0xFF1EA024),
              Color(0xFF3CAD3B),
              Color(0xFF3CAD44),
              Color(0xFF403326),
              Color(0xFF392626),
              Color(0xFF231E22),
              Color(0xFF231E22)
            ],
            stops: [
              0,
              0.35,
              0.35,
              0.37,
              0.37,
              0.41,
              0.41,
              0.49,
              0.49,
              0.59,
              0.71,
              0.71,
              0.75,
              0.75,
              0.81,
              0.81,
              1
            ]),
      ),
    );
  }
}
