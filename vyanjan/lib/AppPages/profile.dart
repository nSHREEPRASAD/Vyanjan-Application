import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vyanjan/AppPages/editprofile.dart';
import 'package:vyanjan/AppPages/myrecipes.dart';
import 'package:vyanjan/Authentication/signup.dart';

class profile extends StatefulWidget {

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

  String val = "My Recipes";
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  var Name="loading..."; 
  var Email="loading...";
  var Bio="loading...";
  var Dp="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestore.collection("Users").doc(auth.currentUser!.uid.toString()).get().then((value){
      setState(() {
        Name=value.data()!["Name"];
        Email=value.data()!["Email"];
        Bio=value.data()!["Bio"];
        Dp=value.data()!["Dp"];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var sh = screen.height;
    var sw = screen.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Profile"),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>myrecipes()));
            }, 
            child: Row(
              children: [
                Icon(Icons.food_bank),
                Text("My Recipes"),
              ],
            ))
        ],
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
                Container(
                  height: sh*0.2,
                  width: sw,
                  color:Dp==""? Colors.grey[400]:Colors.white,
                  child: Dp==""?Center(child: Icon(Icons.person,size: sh*0.2,),):Center(child: Image.network(Dp,fit: BoxFit.fill,),)
                ),
                SizedBox(height: sh*0.01,),
                Row(
                  children: [
                    Text("Name :",style: TextStyle(fontSize: sh*0.04,fontWeight: FontWeight.bold),),
                  ],
                ),
                Container(
                  width: sw,
                  // height: sh*0.08,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: sh*0.0015
                    ),
                    borderRadius: BorderRadius.circular(sh*0.01),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("${Name}",style: TextStyle(fontSize: sh*0.03),),
                  ),
                ),
                SizedBox(height: sh*0.01,),
                Row(
                  children: [
                    Text("Email :",style: TextStyle(fontSize: sh*0.04,fontWeight: FontWeight.bold),),
                  ],
                ),
                Container(
                  width: sw,
                  // height: sh*0.08,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: sh*0.0015
                    ),
                    borderRadius: BorderRadius.circular(sh*0.01),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("${Email}",style: TextStyle(fontSize: sh*0.03),),
                  ),
                ),
                SizedBox(height: sh*0.01,),
                Row(
                  children: [
                    Text("Bio :",style: TextStyle(fontSize: sh*0.04,fontWeight: FontWeight.bold),),
                  ],
                ),
                Container(
                  width: sw,
                  // height: sh*0.08,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: sh*0.0015
                    ),
                    borderRadius: BorderRadius.circular(sh*0.01),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("${Bio}",style: TextStyle(fontSize: sh*0.03),)
                  ),
                ),
                SizedBox(height: sh*0.03,),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>editprofile(Dp, Name, Email,Bio)));
                      }, 
                      child: Text("Edit Profile",style: TextStyle(fontSize: sh*0.03),)
                    ),
                    SizedBox(width: sw*0.025,),
                    ElevatedButton(
                      onPressed: (){
                        auth.signOut().then((value){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("User Signed Out"),
                              backgroundColor: Colors.black,
                              duration: Duration(seconds: 3),
                            )
                          );
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signup()));
                        });
                      }, 
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: sw*0.01,),
                          Text("Sign Out",style: TextStyle(fontSize: sh*0.03),),
                        ],
                      )
                    ),
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