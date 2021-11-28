import 'package:animal_detection/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output="result";
  @override
  void initState(){
    super.initState();
     loadCamera();
     loadModel();

  }

  loadCamera(){
    cameraController=CameraController(cameras![0],ResolutionPreset.medium);
    cameraController!.initialize().then((value) =>{
      if(mounted){
        setState(() {
          cameraController!.startImageStream((imageStream){
            cameraImage=imageStream;
            runModel();
          });
        })
      }
    
    });

  }
  runModel()async{
    if(cameraImage!=null){
      var predictions = await Tflite.runModelOnFrame(bytesList:cameraImage!.planes.map((plane){
        return plane.bytes;
      }).toList(),

      imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        // imageMean: 127.5,
        // rotation: 90,
        // numResults:2,
        // threshold: 0.1,
        asynch: true,
      );
      for (var element in predictions!) {
          print(element);
          if(element.confidence > 0.7) {
            setState(() {
              output = element['label'];
            });
            break;
          } else {
            setState(() {
              output = 'CHud gaya code';
          });
        }
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
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
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
          OutlinedButton(onPressed:(){

          },
            child:const Text("From Gallery"),
          style: ButtonStyle(),),
          OutlinedButton(onPressed:(){}, child:const Text("From Camera")),

          Text(output,
          style: const TextStyle(fontWeight: FontWeight.w600,fontSize:18,),)
        ],
      ),

    );
  }
}
