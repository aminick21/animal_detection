// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:animal_detection/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = "";
  String time = "";

  File? image;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future pickImage(String source) async {
    late final image;
    try {
      if (source == "gallery") {
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
      }
      if (source == "camera") {
        image = await ImagePicker().pickImage(source: ImageSource.camera);
      }

      if (image == null) {
        return;
      }
      final tempImage = File(image.path);
      setState(() {
        this.image = tempImage;
      });
      runModel();
    } on PlatformException catch (e) {
      print("failed to load image");
    }
  }

  String split(String str) {
    List<String> s = str.split(" ");
    return s[1];
  }

  runModel() async {
    if (image != null) {
      var predictions = await Tflite.runModelOnImage(
        path: image!.path,
        numResults: 2,
        threshold: .5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      if (predictions != null) {
        if (predictions[0]['confidence'] > .8) {
          setState(() {
            output = split(predictions[0]['label']);
            DateTime now = DateTime.now();
            time = now.hour.toString() +
                ":" +
                now.minute.toString() +
                ":" +
                now.second.toString();
          });
        } else {
          setState(() {
            output = "Cannot recognise";
          });
        }
      } else {
        setState(() {
          output = "Cannot recognise";
        });
      }
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "Select Image",
                    style: TextStyle(
                        fontFamily: "LibreCaslonDisplay",
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(100)),
                ),
              ),
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(100))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Container(
                      height: 450,
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 5,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        borderRadius: BorderRadius.circular(85),
                      ),
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: Image.file(
                                image!,
                                height: 300,
                                width: 300,
                                fit: BoxFit.fill,
                              ))
                          : Expanded(
                              child: Column(
                              children: [
                                Image(image: AssetImage("assets/tiger2.png")),
                                Text("Image Here",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                              ],
                            )),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              pickImage("gallery");
                            },
                            child: const Text(
                              "Gallery",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black,
                              fixedSize: Size(150, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              pickImage("camera");
                            },
                            child: const Text(
                              "Camera",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black,
                              fixedSize: Size(150, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            )),
                      ],
                    ),
                    // Text(
                    //   output,
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 18,
                    //   ),
                    // ),
                    // Text(
                    //   time,
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 18,
                    //   ),
                    // ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Center(
                            child: Text(
                          "Check",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                        )),
                        height: 80,
                        width: 130,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    // path starts with (0.0, 0.0) point (1)
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        size.height / 2 + 20, size.width / 2 + 20, 0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
