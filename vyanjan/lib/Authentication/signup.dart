import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vyanjan/AppPages/bottomnavigationbar.dart';
import 'package:vyanjan/Authentication/loading.dart';
import 'package:vyanjan/Authentication/signin.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final namekey = GlobalKey<FormState>();
  final emailkey = GlobalKey<FormState>();
  final passwordkey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  bool obscure = true;
  String Name="";
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var sh = screen.height;
    var sw = screen.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: sh,
          width: sw,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: sh*0.35,
                  child: Lottie.asset("assets/animations/Authentication.json"),
                ),
                SizedBox(height: sh*0.02,),
                Container(
                  width: sw*0.8,
                  child: Form(
                    key: namekey,
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isNotEmpty){
                          return null;
                        }
                        else{
                          return "Please Enter Name";
                        }
                      },
                      keyboardType: TextInputType.name,
                      controller: namecontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Name",
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
                  width: sw*0.8,
                  child: Form(
                    key: emailkey,
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isNotEmpty){
                          return null;
                        }
                        else{
                          return "Please Enter Email Address";
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email",
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
                  width: sw*0.8,
                  child: Form(
                    key: passwordkey,
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isNotEmpty){
                          return null;
                        }
                        else{
                          return "Please Enter Password";
                        }
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscure,
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              obscure=!obscure;
                            });
                          }, 
                          icon: obscure?Icon(Icons.remove_red_eye) : Icon(Icons.cancel)
                        ),
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
                SizedBox(height: sh*0.02,),
                Container(
                  width: sw*0.8,
                  child: Row(
                    children: [
                      Text("Already have an account ?",style: TextStyle(fontSize: sh*0.025),),
                      TextButton(
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signin()));
                        }, 
                        child: Text("Sign In",style: TextStyle(color: Colors.blue,fontSize: sh*0.025),)
                      )
                    ],
                  ),
                ),
                Container(
                  width: sw*0.8,
                  child: ElevatedButton(
                    onPressed: (){
                      if(namekey.currentState!.validate() && emailkey.currentState!.validate() && passwordkey.currentState!.validate()){
                        auth.createUserWithEmailAndPassword(
                            email: emailcontroller.text.toString(), 
                            password: passwordcontroller.text.toString()
                          ).then((value){
                            firestore.collection("Users").doc(auth.currentUser!.uid.toString()).set({                                                                                           
                              "Name":namecontroller.text.toString(),
                              "Email":emailcontroller.text.toString(),
                              "Dp":"",
                              "Bio":"-",
                              "Recipes":0,
                            });
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loading()));
                          }).onError((error, stackTrace){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("User Already Present"),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                              )
                            );
                          });
                      }
                      else{
                        return;
                      }
                    }, 
                    child: Text("Sign Up")
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