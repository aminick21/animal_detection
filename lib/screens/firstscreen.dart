// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  bool show = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 100, 0, 10),
              child: Text(
                "WANT TO KNOW",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              "Who's chirping?",
              style: TextStyle(
                fontSize: 40,
                fontFamily: "LibreCaslonDisplay",
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            FadeTransition(
              opacity: _animation,
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mic,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        SizedBox(width:10,),
                        Text(
                          "LET US HEAR IT",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white),
                        ),
                      ],
                    ),
                   style: OutlinedButton.styleFrom(
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                     fixedSize: Size(250, 70),
                     backgroundColor: Colors.black,
                   ),
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      "EXPLORE",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      side:BorderSide(width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      fixedSize: Size(250, 70),
                    ),
                  ),
                ],
              ),
            ),
            Image(
              image: AssetImage("assets/tiger.png"),
            )
          ],
        ),
      ),
    );
  }
}
