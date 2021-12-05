import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class foodcontent extends StatefulWidget {
  final String foodname;
  final String pagetitle;
  foodcontent(this.foodname,this.pagetitle);
  @override
  _foodcontentState createState() => _foodcontentState();
}

class _foodcontentState extends State<foodcontent> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection(widget.pagetitle);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: FutureBuilder<DocumentSnapshot>(
            future: users.doc(widget.foodname).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data();

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(data["name"].toString().toUpperCase(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                          child: Image.network(data["img"])
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        children: [
                          Text("How is it done? ".toUpperCase() + "\n" + data["content"],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17)),
                          SizedBox(height: 30,),
                          Text("recipe; ".toUpperCase() + "\n" + data["recipe"],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15)),
                          SizedBox(height: 30,),
                          Text("ingredients; ".toUpperCase() + "\n" + data["ingredients"]),
                        ],
                      ),
                    ),

                  ],
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
