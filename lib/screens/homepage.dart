import 'package:flutter/material.dart';

import 'listfood.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var mainfoodtitle = [
    "breakfast",
    "soup",
    "dinner",
    "fish",
    "salad",
    "dessert",
  ];
  var mainfoodimg = [
    "assets/mainimages/breakfast.jpg",
    "assets/mainimages/soup.jpg",
    "assets/mainimages/dinner.jpg",
    "assets/mainimages/fish.jpg",
    "assets/mainimages/salad.jpg",
    "assets/mainimages/dessert.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(

        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(mainfoodtitle.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(mainfoodimg[index]),
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                          )
                        ),
                        child: Center(child: Text(mainfoodtitle[index],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.black),)),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>listfood(mainfoodtitle[index])));
                      },
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
