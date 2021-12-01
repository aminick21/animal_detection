// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:animal_detection/screens/homescreen.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
final File image;
final String result;

Map? map = {"Elephant":"Elephants are the largest land mammals on earth and have distinctly massive bodies, large ears, and long trunks. They use their trunks to pick up objects, trumpet warnings, greet other elephants, or suck up water for drinking or bathing, among other uses.",
  "Bear":"Bears are mammals that belong to the family Ursidae. They can be as small as four feet long and about 60 pounds (the sun bear) to as big as eight feet long and more than a thousand pounds (the polar bear). They’re found throughout North America, South America, Europe, and Asia.",
  "Tiger":"The tiger is the largest living cat species and a member of the genus Panthera. It is most recognisable for its dark vertical stripes on orange fur with a white underside. An apex predator, it primarily preys on ungulates such as deer and wild boar.",
  "Wolf":"The wolf, also known as the gray wolf or grey wolf, is a large canine native to Eurasia and North America. More than thirty subspecies of Canis lupus have been recognized, and gray wolves, as colloquially understood, comprise non-domestic/feral subspecies. The wolf is the largest extant member of the family Canidae.",
  "Rhino":"A rhinoceros, commonly abbreviated to rhino, is a member of any of the five extant species of odd-toed ungulates in the family Rhinocerotidae. Two of the extant species are native to Africa, and three to South and Southeast Asia.",};
SecondScreen({required this.image,required this.result});
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
                    "You Found a $result",
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

            Expanded(child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(100))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  Container(
                    height: 250,
                    width: 250,
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
                          image,
                          height: 250,
                          width: 250,
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
                  Align(
                    alignment:Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child: Text("About",style: TextStyle(fontSize:30,fontWeight: FontWeight.w600,fontFamily: "LibreCaslonDisplay",letterSpacing: 2),),
                    ),
                  ),
                  Divider(thickness: 5,
                    indent: 50,
                    endIndent: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    child: Text(map![result],style: TextStyle(fontSize:25,),),
                  ),
                  Spacer(),
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
                  SizedBox(height: 30,),

                ],
              ),
            )),
          ],
        ),
      ),

    );
  }
}
