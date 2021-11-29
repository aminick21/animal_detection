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
  String output="";

  File? image;
  @override
  void initState(){
    super.initState();
     loadModel();

  }

  Future pickImage(String source) async{
   late final image;
   try {
      if(source=="gallery") {
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
      }
      if(source=="camera"){
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
   }on PlatformException catch(e){
     print("failed to load image");
   }

  }

  String split(String str ){
    List<String> s =str.split(" ");
    return s[1];
  }

  runModel()async{
    if(image!=null){
      var predictions=await Tflite.runModelOnImage(path: image!.path,
        numResults:2,
        threshold: .5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      if(predictions!=null){
      if(predictions[0]['confidence']>.8){
        setState(() {
          output=split(predictions[0]['label']);
        });
      }
      else{ setState(() {
        output="Cannot recognise";
      });

      }}
      else{
        setState(() {
        output="Cannot recognise";
      });

      }

    }
  }
  loadModel()async{
    await Tflite.loadModel(model: "assets/model_unquant.tflite",
    labels: "assets/labels.txt");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animal Detection"),centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
              // child: Container(
              //   height: MediaQuery.of(context).size.height*0.7,
              //   width: MediaQuery.of(context).size.width,
              //   child: !cameraController!.value.isInitialized?
              //   Container():AspectRatio(aspectRatio:cameraController!.value.aspectRatio,
              //   child: CameraPreview(cameraController!),),
              // ),
            // ),
            image!=null?Image.file(image!,height: 300,width: 300,fit: BoxFit.cover,):FlutterLogo(size: 160,),
            OutlinedButton(onPressed:(){
              pickImage("gallery");
            },
              child:const Text("From Gallery"),
            style: const ButtonStyle(),),
            OutlinedButton(onPressed:(){
              pickImage("camera");
            },
                child:const Text("From Camera")),

            Text(output,
            style: const TextStyle(fontWeight: FontWeight.w600,fontSize:18,),)
          ],
        ),
      ),

    );
  }
}
