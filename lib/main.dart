import 'package:animal_detection/screens/firstscreen.dart';
import 'package:animal_detection/screens/homescreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? cameras;

void main() async {
WidgetsFlutterBinding.ensureInitialized();
cameras = await availableCameras();
  runApp(MaterialApp(
    home: FirstScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor:const Color(0xfff5ab41),
      ),
  )
  );
}

