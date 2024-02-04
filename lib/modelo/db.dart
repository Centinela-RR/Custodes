import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConnection {
  final db = FirebaseFirestore.instance;
  // Upload payload
  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };

  void addNewElement(){  
    // Add a new document with a generated ID
    /*db.collection("test").add(user).then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}')) {
      // TODO: implement then
      throw UnimplementedError();
    }*/
  }

  Future<void> fetchElement() async {
    List<String> outputList = [];
    await db.collection("test").get().then((event) {
      for (var doc in event.docs) {
        String output = "${doc.id} => ${doc.data()}";
        debugPrint(output);
        outputList.add(output);
      }
    });
  }

  String generateLocalIdentifier() {
    return "a";
  }

  Future<void> storeLocalIdentifier(String localIdentifier) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('localIdentifier', localIdentifier);
  }

  Future<String?> getLocalIdentifier() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('localIdentifier');
  }
}
