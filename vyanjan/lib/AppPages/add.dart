import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  bool loading = false;
  String imgUrl="";
  String imgPath = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController ingredientscontroller = TextEditingController();
  TextEditingController instructionscontroller = TextEditingController();

  final namekey = GlobalKey<FormState>();
  final descriptionkey = GlobalKey<FormState>();
  final ingredientskey = GlobalKey<FormState>();
  final instructionskey = GlobalKey<FormState>();

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var sh = screen.height;
    var sw = screen.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Post a Recipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
        child: Container(
          height: sh,
          width: sw,
          // color: Colors.amber,
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  child: Card(
                    color: Colors.grey[300],
                    elevation: 10,
                    child: Container(
                      height: sh*0.3, 
                      width: sw,
                      child: Stack(
                        children: [
                          Center(
                            child: imgPath==""? Icon(Icons.food_bank,size: sh*0.3,): Image.file(File(imgPath),fit: BoxFit.fill,)
                          ),
                          imgPath!=""?
                          Positioned(
                            top: sh*0.02,
                            right: sh*0.02,
                            child: IconButton(
                              onPressed: (){
                                setState(() {
                                  imgPath="";
                                });
                              }, 
                              icon: Icon(Icons.cancel,size: sh*0.05,)
                            )
                          ):
                          Text("")
                        ]
                      ),
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context, 
                      builder: (context){
                        return Container(
                          height: sh*0.1,
                          child: Row(
                            children: [
                              SizedBox(
                                width: sw*0.2,
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
                                }, 
                                icon: Icon(Icons.camera_alt,size: sh*0.05,)
                              ),
                              SizedBox(
                                width: sw*0.35 ,
                              ),
                              IconButton(
                                onPressed: ()async{
                                  Navigator.pop(context);
                                  setState(() {
                                    imgPath="";
                                  });
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(source:ImageSource.gallery);

                                  if(file==null) return;
                                  setState(() {
                                    imgPath=file.path;
                                  });
                                }, 
                                icon: Icon(Icons.image,size: sh*0.05,)
                              )
                            ],
                          ),
                        );
                      }
                    );
                  },
                ),
                SizedBox(height: 0.05*sh,),
                Container(
                    width: sw,
                    child: Form(
                      key: namekey,
                      child: TextFormField(
                        validator: (value) {
                          if(value!.isNotEmpty){
                            return null;
                          }
                          else{
                            return "Please Enter Recipe Name";
                          }
                        },
                        controller: namecontroller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.food_bank),
                          hintText: "Recipe Name",
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: sh*0.002
                            )
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: sh*0.003
                            )
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: sh*0.002
                            )
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 0.02*sh,),
                Container(
                    width: sw,
                    child: Form(
                      key: descriptionkey,
                      child: TextFormField(
                        validator: (value) {
                          if(value!.isNotEmpty){
                            return null;
                          }
                          else{
                            return "Please Enter Recipe Description";
                          }
                        },
                        controller: descriptioncontroller,
                        maxLines: 5,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.description),
                          hintText: "Description",
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: sh*0.002
                            )
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: sh*0.003
                            )
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: sh*0.002
                            )
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 0.02*sh,),
                  Container(
                    width: sw,
                    child: Form(
                      key: ingredientskey,
                      child: TextFormField(
                        validator: (value) {
                          if(value!.isNotEmpty){
                            return null;
                          }
                          else{
                            return "Please Enter Recipe Ingredients";
                          }
                        },
                        controller: ingredientscontroller,
                        maxLines: 5,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.palette),
                          hintText: "Ingredients",
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: sh*0.002
                            )
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: sh*0.003
                            )
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: sh*0.002
                            )
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 0.02*sh,),
                  Container(
                    width: sw,
                    child: Form(
                      key: instructionskey,
                      child: TextFormField(
                        validator: (value) {
                          if(value!.isNotEmpty){
                            return null;
                          }
                          else{
                            return "Please Enter Recipe Instructions";
                          }
                        },
                        controller: instructionscontroller,
                        maxLines: 5,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.edit),
                          hintText: "Instructions",
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: sh*0.002
                            )
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: sh*0.003
                            )
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(sh*0.02),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: sh*0.002
                            )
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 0.02*sh,),
                  Container(
                    width: sw,
                    child: ElevatedButton(
                      onPressed: ()async{
                        setState(() {
                          loading=true;
                        });
                        Timer(Duration(seconds: 10), () { 
                          setState(() {
                            loading=false;
                          });
                        });
                        if(imgPath==""){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Upload Dish Image"),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            )
                          );
                        }
                        else if(namekey.currentState!.validate() && descriptionkey.currentState!.validate() && ingredientskey.currentState!.validate() && instructionskey.currentState!.validate()){
                          String uniquename = DateTime.now().millisecondsSinceEpoch.toString();
                          Reference refRoot = FirebaseStorage.instance.ref();
                          Reference refDir = refRoot.child("Recipes");
                          Reference refFile = refDir.child(uniquename);

                          try{
                            await refFile.putFile(File(imgPath));
                            imgUrl = await refFile.getDownloadURL();

                            firestore.collection("Recipes").doc(auth.currentUser!.uid.toString()).collection("MyRecipes").doc().set({
                              "Recipe Name":namecontroller.text.toString(),
                              "Recipe Description":descriptioncontroller.text.toString(),
                              "Recipe Ingredients":ingredientscontroller.text.toString(),
                              "Recipe Instructions":instructionscontroller.text.toString(),
                              "Recipe Image":imgUrl.toString()
                            }).then((value){
                              namecontroller.clear();
                              descriptioncontroller.clear();
                              ingredientscontroller.clear();
                              instructionscontroller.clear();
                              setState(() {
                                imgPath="";
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Recipe Added Successfully"),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 3),
                                  )
                                );
                            });      
                          }
                          catch(e){
                            //error
                          }
                        }
                        else{
                          return;
                        }
                      }, 
                      child: loading==true?Center(child: CircularProgressIndicator(),): Text("Add Recipe")
                    ),
                  )
              ],
            ),
          ),
        ),
      )
    );
  }
}