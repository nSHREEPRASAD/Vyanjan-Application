import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class addvideo extends StatefulWidget {
  const addvideo({super.key});

  @override
  State<addvideo> createState() => _addvideoState();
}

class _addvideoState extends State<addvideo> {
  VideoPlayerController? _controller;
  String filePath="";
  String vdoUrl="";
  @override
  Widget build(BuildContext context) {

    var screen = MediaQuery.of(context).size;
    var sh = screen.height;
    var sw = screen.width;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: sw,
        height: sh,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: 
          filePath==""?
          Container(
            height: sh,
            width: sw,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(sh*0.05)
            ),
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: sw*0.07,),
                  IconButton(
                    onPressed:(){

                    } , 
                    icon: Icon(Icons.image,size: sh*0.15),),
                  SizedBox(width: sw*0.07,),
                  IconButton(
                    onPressed:() async{
                      if(filePath!=""){
                        setState(() {
                          filePath="";
                        });
                      }
                      ImagePicker VideoPicker = ImagePicker();
                      XFile? file = await VideoPicker.pickVideo(source:ImageSource.camera);

                      setState(() {
                        filePath=file!.path;
                      });

                      _controller= VideoPlayerController.file(File(filePath))
                      ..initialize().then((_){
                        setState(() {
                          _controller!.play();
                        });
                      });
                      
                    } , 
                    icon: Icon(Icons.camera,size: sh*0.15)),
                ],
              ),
            ),
          ):
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Stack(
              children: [
                Container(
                  height: sh,
                  width: sw,
                  child: VideoPlayer(_controller!),
                ),
                Positioned(
                  top: sh*0.02,
                  right: sh*0.02,
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        filePath="";
                      });
                    }, 
                    icon: Icon(Icons.cancel,size: sh*0.05,)),
                )
              ],
            ),
          )
        )
      ),
    );
  }
}