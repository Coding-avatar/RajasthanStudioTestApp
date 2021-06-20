import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pexel/view/homeScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff07a081),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'Assets/images/logo.png',
              width: MediaQuery.of(context).size.width * .8,
            ),
          ),
        ],
      ),
    );
  }
}
