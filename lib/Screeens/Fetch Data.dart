import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Fetch extends StatefulWidget {
  const Fetch({super.key});

  @override
  State<Fetch> createState() => _FetchState();
}

class _FetchState extends State<Fetch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
        centerTitle: true,

      ),
      body: StreamBuilder(stream:FirebaseFirestore.instance.collection("Data").snapshots(), builder:(context, snapshot) {
        if(snapshot.hasData){
         return ListView.builder(itemBuilder: (context, index) {
           return Card(
             color: Colors.yellowAccent.withOpacity(0.4),

             child: ListTile(
               leading: CircleAvatar(
                 radius: 50,
                 backgroundImage: NetworkImage("${snapshot.data!.docs[index] ["ImageName"]}"),

               ),
               title:Text("${snapshot.data!.docs[index] ["Title"]}"),
               subtitle: Text("${snapshot.data!.docs[index]["Decs"]}"),
trailing: Text("${index+1}",style: TextStyle(fontSize: 20)),
             ),
           );
         },itemCount: snapshot.data!.docs.length,);
        }
        else{
          return Center(child: Text("No data"),);
        }
      },),
    );
  }
}
