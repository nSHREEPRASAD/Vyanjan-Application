import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vyanjan/AppPages/bottomnavigationbar.dart';

class loading extends StatefulWidget {


  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottomnavigationbar()));
    });
  }
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var sh = screen.height;
    var sw = screen.width;
    return Scaffold(
      body: Center(
        child: Container(
          height: sh*0.35,
          width: sw*0.8,
          child: Lottie.asset("assets/animations/AuthLoading.json"),
        ),
      ),
    );
  }
}