import 'package:animal_detection/homescreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? cameras;

void main() async {
WidgetsFlutterBinding.ensureInitialized();
cameras = await availableCameras();
  runApp(const MaterialApp(home:HomeScreen(),));
}

