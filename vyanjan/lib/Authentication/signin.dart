import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vyanjan/Authentication/loading.dart';
import 'package:vyanjan/Authentication/signup.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final namekey = GlobalKey<FormState>();
  final emailkey = GlobalKey<FormState>();
  final passwordkey = GlobalKey<FormState>();
  bool obscure = true;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var sh = screen.height;
    var sw = screen.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Sign In"),
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
                    key: emailkey,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email",
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1
                          )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2
                          )
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1
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
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1
                          )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2
                          )
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1
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
                      Text("Don't have an account ?",style: TextStyle(fontSize: sh*0.025),),
                      TextButton(
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signup()));
                        }, 
                        child: Text("Sign Up",style: TextStyle(color: Colors.blue,fontSize: sh*0.025),)
                      )
                    ],
                  ),
                ),
                Container(
                  width: sw*0.8,
                  child: ElevatedButton(
                    onPressed: (){
                      auth.signInWithEmailAndPassword(
                        email: emailcontroller.text.toString(), 
                        password: passwordcontroller.text.toString()
                      ).then((value){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loading()));
                      }).onError((error, stackTrace){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Incorrect Email or Password"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          )
                        );
                      });
                    }, 
                    child: Text("Sign In")
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