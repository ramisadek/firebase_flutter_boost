import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  num x;

  List names = List();
  List prices = List();

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  // Create a CollectionReference called users that references the firestore collection
  CollectionReference products = FirebaseFirestore.instance.collection('products');


  Future getData() {
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        names.add(doc["name"]);
        prices.add(doc['price']);
      })
    });
  }

  Future<void> addNewProduct() {
    // Call the user's CollectionReference to add a new user
    return products
        .add({
      'name': "volex", // John Doe
      'price': 20, // Stokes and Sons
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context,index){
          return Column(
            children: [
              Text("${names[index]}"),
              Text("${prices[index]}"),
            ],
          );
        },
      ),
    );


    // return Scaffold(
    //   body: FutureBuilder<DocumentSnapshot>(
    //     future: products.doc("X5DRMkUgRCQ2DpHtOIv1").get(),
    //     builder:
    //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //
    //       if (snapshot.hasError) {
    //         return Text("Something went wrong");
    //       }
    //
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         Map<String, dynamic> data = snapshot.data.data();
    //         return Center(
    //           child: Text("Name: ${data['name']}, price: ${data['price']}"),
    //         );
    //       }
    //
    //       return Center(child: Text("loading"),);
    //     },
    //   ),
    // );
    //
    // return Scaffold(
    //   body: Center(
    //     child: TextButton(
    //       onPressed: addNewProduct,
    //       child: Text(
    //         "Add User",
    //       ),
    //     ),
    //   ),
    // );
  }
}
