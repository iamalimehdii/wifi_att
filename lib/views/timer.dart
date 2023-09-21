import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';

const Color green = Color(0xff006600);

class TimerPage extends StatelessWidget {
  final String description;
  final Widget timer;
  final bool inverted;

  const TimerPage({
    required this.description,
    required this.timer,
    this.inverted = false,
    Key? key,
    required String title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Align(
              // Wrap the timer in an Align widget
              alignment: Alignment.center,
              child: timer,
            ),
          ),
        ],
      ),
    );
  }
}
