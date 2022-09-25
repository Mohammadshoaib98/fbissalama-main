import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyTimer();
  }
}

class MyTimer extends StatefulWidget {
   MyTimer();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyTimer> {
  int seconds = 60;
  Timer? _timer;

  void _startTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _startTimer();
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'This code will expired after:',
            style: GoogleFonts.sahitya(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xFF37474F)),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '00:00:$seconds',
            style: GoogleFonts.sahitya(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Color(0xFFFFC727),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
