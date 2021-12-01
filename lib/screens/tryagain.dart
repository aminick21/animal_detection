// ignore_for_file: prefer_const_constructors

import 'package:animal_detection/screens/homescreen.dart';
import 'package:flutter/material.dart';

class TryAgain extends StatelessWidget {
  const TryAgain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/tiger3.png")),
            Text("No Results Found",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600,letterSpacing: 2),),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    HomeScreen()));
              },
              child: Container(
                child: Center(
                    child: Text(
                      "Try Again",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    )),
                height: 60,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
