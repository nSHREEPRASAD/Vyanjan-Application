import 'package:flutter/material.dart';

class fullrecipe extends StatefulWidget {
  var image;
  var name;
  var desc;
  var ingre;
  var instru;

  fullrecipe(
    this.image,
    this.name,
    this.desc,
    this.ingre,
    this.instru
  );

  @override
  State<fullrecipe> createState() => _fullrecipeState(image,name,desc,ingre,instru);
}

class _fullrecipeState extends State<fullrecipe> {
  var image;
  var name;
  var desc;
  var ingre;
  var instru;

  _fullrecipeState(
    this.image,
    this.name,
    this.desc,
    this.ingre,
    this.instru
  );
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var sh = screen.height;
    var sw = screen.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: sw,
          height: sh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("#${name}",style: TextStyle(decoration: TextDecoration.underline, fontSize: 40,fontWeight: FontWeight.bold,color: Colors.purple[900],fontStyle: FontStyle.italic,),),
                SizedBox(height: sh*0.01,),
                Image.network(image, height: sh*0.4, width: sw, fit: BoxFit.fill,),
                SizedBox(height: sh*0.05,),
                Container(
                  width: sw,
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Recipe Name:",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Text(name,style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: sh*0.02,),
                Container(
                  width: sw,
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Recipe Description:",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Text(desc,style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: sh*0.02,),
                Container(
                  width: sw,
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Recipe Ingredients:",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Text(ingre,style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: sh*0.02,),
                Container(
                  width: sw,
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Recipe Instructions:",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Text(instru,style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}