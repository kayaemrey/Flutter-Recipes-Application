import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recieps/screens/foodcontent.dart';

class listfood extends StatefulWidget {
  final String pagetitle;
  listfood(this.pagetitle);
  @override
  _listfoodState createState() => _listfoodState();
}

class _listfoodState extends State<listfood> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection(widget.pagetitle).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pagetitle.toUpperCase()+ " LİST",style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return new ListTile(
                  title: InkWell(
                    child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(document.data()["img"]),
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(document.data()["name"].toString().toUpperCase(),style: TextStyle(fontSize: 23,fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
                          ],
                        )),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>foodcontent(document.id,widget.pagetitle)));
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
