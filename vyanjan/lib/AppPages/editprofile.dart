import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vyanjan/AppPages/bottomnavigationbar.dart';
import 'package:vyanjan/AppPages/home.dart';
import 'package:vyanjan/AppPages/profile.dart';

class editprofile extends StatefulWidget {
  var Dp;
  var Name;
  var Email;
  var Bio;
  editprofile(
    this.Dp,
    this.Name,
    this.Email,
    this.Bio
  );

  @override
  State<editprofile> createState() => _editprofileState(Dp,Name,Email,Bio);
}

class _editprofileState extends State<editprofile> {
  var Dp;
  var Name;
  var Email;
  var Bio;
  _editprofileState(
    this.Dp,
    this.Name,
    this.Email,
    this.Bio
  );
  final storage = FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final namekey = GlobalKey<FormState>();
  final emailkey = GlobalKey<FormState>();
  final biokey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController(); 
  String imgUrl="";
  String imgPath = ""; 
  bool isLoading = false;  

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var sh = screen.height;
    var sw = screen.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Edit Profile"),
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: sh,
          width: sw,
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  child: Container(
                  height: sh*0.2,
                  width: sw,
                  color: Dp=="" && imgPath==""? Colors.grey[400]:Colors.white,
                  child: Dp=="" && imgPath==""?Center(child: Icon(Icons.person,size: sh*0.2,),):imgPath!=""?Image.file(File(imgPath)):Center(child: Image.network(Dp),)
                ),
                  onTap: (){
                    showModalBottomSheet(
                      context: context, 
                      builder: (context){
                        return Container(
                          height: sh*0.1,
                          child: 
                          Dp!="" || imgPath!=""?
                          Row(
                            children: [
                              SizedBox(
                                width: sw*0.15,
                              ),
                              IconButton(
                                onPressed: ()async{
                                  Navigator.pop(context);
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(source:ImageSource.camera);
                                  if(file==null) return;
                                  if(imgPath!=""){
                                    setState(() {
                                      imgPath="";
                                    });
                                  }
                                  setState(() {
                                    imgPath=file.path;
                                  });
                                  storage.ref().child("Profile").child(auth.currentUser!.uid.toString()).delete();
                                }, 
                                icon: Icon(Icons.camera_alt,size: sh*0.05,)
                              ),
                              SizedBox(
                                width: sw*0.15 ,
                              ),
                              IconButton(
                                onPressed: ()async{
                                  Navigator.pop(context);
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(source:ImageSource.gallery);
                                  if(file==null) return;
                                  if(imgPath!=""){
                                    imgPath="";
                                  }
                                  setState(() {
                                    imgPath=file.path;
                                  });
                                  storage.ref().child("Profile").child(auth.currentUser!.uid.toString()).delete();
                                }, 
                                icon: Icon(Icons.image,size: sh*0.05,)
                              ),
                              SizedBox(
                                width: sw*0.15 ,
                              ),
                              IconButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                  if (imgPath!="" || Dp!=""){
                                    setState(() {
                                      imgPath="";
                                      Dp="";
                                    });
                                    storage.ref().child("Profile").child(auth.currentUser!.uid.toString()).delete(); 
                                  }
                                }, 
                                icon: Icon(Icons.cancel, size: sh*0.05,)
                              )
                            ],
                          ):
                          Row(
                            children: [
                              SizedBox(
                                width: sw*0.15,
                              ),
                              IconButton(
                                onPressed: ()async{
                                  Navigator.pop(context);
                                  if(imgPath!=""){
                                    setState(() {
                                      imgPath="";
                                    });
                                  }
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(source:ImageSource.camera);

                                  if(file==null) return;
                                  setState(() {
                                    imgPath=file.path;
                                  });
                                  print(imgPath);
                                }, 
                                icon: Icon(Icons.camera_alt,size: sh*0.05,)
                              ),
                              SizedBox(
                                width: sw*0.4 ,
                              ),
                              IconButton(
                                onPressed: ()async{
                                  Navigator.pop(context);
                                  if(imgPath!=""){
                                    imgPath="";
                                  }
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(source:ImageSource.gallery);

                                  if(file==null) return;
                                  setState(() {
                                    imgPath=file.path;
                                  });
                                }, 
                                icon: Icon(Icons.image,size: sh*0.05,)
                              ),
                              SizedBox(
                                width: sw*0.15 ,
                              ),
                            ],
                          ),
                        );
                      }
                    );
                  },
                ),
                SizedBox(height: sh*0.02,),
                Row(
                  children: [
                    Text("Name :",style: TextStyle(fontSize: sh*0.04,fontWeight: FontWeight.bold),),
                  ],
                ),
                Container(
                  width: sw,
                  // height: sh*0.08,
                  child: Form(
                    key: namekey,
                    child: TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        hintText: "${Name}",
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(sh*0.02),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: sh*0.002
                          ), 
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(sh*0.02),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: sh*0.002
                          ), 
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(sh*0.02),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: sh*0.002
                          ), 
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: sh*0.01,),
                Row(
                  children: [
                    Text("Bio :",style: TextStyle(fontSize: sh*0.04,fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: sh*0.01,),
                Container(
                  width: sw,
                  // height: sh*0.08,
                  child: Form(
                    key: biokey,
                    child: TextFormField(
                      controller: biocontroller,
                      decoration: InputDecoration(
                        hintText: "${Bio}",
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(sh*0.02),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: sh*0.002
                          ), 
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(sh*0.02),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: sh*0.002
                          ), 
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(sh*0.02),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: sh*0.002
                          ), 
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: sh*0.05,),
                Row(
                  children: [
                    // namekey.currentState!.validate() || biokey.currentState!.validate() || imgUrl!=""?
                    ElevatedButton(
                      onPressed: () async{
                        setState(() {
                          isLoading=true;
                        });
                        Timer(Duration(seconds: 10), () { 
                          setState(() {
                            isLoading=false;
                          });
                        });
                        Reference Root = FirebaseStorage.instance.ref();
                        Reference Dir = Root.child("Profile");
                        Reference Photo = Dir.child(auth.currentUser!.uid.toString());
                        try{
                          await Photo.putFile(File(imgPath));
                          imgUrl= await Photo.getDownloadURL();
                        }
                        catch(err){
                          //error
                        }
                        await firestore.collection("Users").doc(auth.currentUser!.uid.toString()).update({
                          "Name":namecontroller.text.toString()==""?Name:namecontroller.text.toString(),
                          "Bio":biocontroller.text.toString()==""?Bio:biocontroller.text.toString(),
                          "Dp":imgUrl==""?Dp:imgUrl
                        });
                        if(Dp=="" && imgUrl==""){
                          FirebaseStorage.instance.ref().child("Profile").child(auth.currentUser!.uid.toString()).delete();
                        }
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Profile Edited Successfully"),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 3),
                          )
                        );
                      }, 
                      child: 
                      isLoading==true?
                      Center(child: CircularProgressIndicator(),):
                      Row(
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: sw*0.005,),
                          Text("Yes")
                        ],
                      )
                    ),
                    SizedBox(width: 0.05*sw,),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: Row(
                        children: [
                          Icon(Icons.cancel),
                          SizedBox(width: sw*0.005,),
                          Text("Cancel")
                        ],
                      )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}