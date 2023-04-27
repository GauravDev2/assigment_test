import 'dart:async';

import 'package:assigment_test/authentication/register_page.dart';
import 'package:assigment_test/authentication/Login_page.dart';
import 'package:flutter/material.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}


class _SpalshScreenState extends State<SpalshScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) => startTime());
  }

  startTime() {
    var duration = Duration(seconds: 2);
    return Timer(duration, ()
    {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen()),
              (Route<dynamic> route) => false);
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // height: MediaQuery.of(context).size.height * 0.8,
          child: TweenAnimationBuilder(
              builder: (context, double value, child) => Opacity(
                opacity: value,
                child: child,
              ),
              duration: Duration(seconds: 4),
              tween: Tween(begin: 0.0, end: 1.0),
              child:
              Center(child: Image.asset("images/studyimage.gif"))),
        ),
    );
  }


}
