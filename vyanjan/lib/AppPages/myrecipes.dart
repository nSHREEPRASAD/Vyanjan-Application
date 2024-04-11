import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vyanjan/AppPages/fullrecipe.dart';

class myrecipes extends StatefulWidget {
  const myrecipes({super.key});

  @override
  State<myrecipes> createState() => _myrecipesState();
}

class _myrecipesState extends State<myrecipes> {
  var firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var sh = screen.height;
    var sw = screen.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My Recipes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: sh,
          width: sw,
          child: StreamBuilder(
            stream: firestore.collection("Recipes").doc(auth.currentUser!.uid.toString()).collection("MyRecipes").snapshots(), 
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          child: Image.network(snapshot.data!.docs[index]["Recipe Image"],fit: BoxFit.fill,),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>fullrecipe(snapshot.data!.docs[index]["Recipe Image"], snapshot.data!.docs[index]["Recipe Name"], snapshot.data!.docs[index]["Recipe Description"], snapshot.data!.docs[index]["Recipe Ingredients"], snapshot.data!.docs[index]["Recipe Instructions"])));
                        },
                      ),
                    );          
                  },
                );
              }
              else{
                return Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ),
      ),
    );
  }
}