import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirebaseConnection {
  final db = FirebaseFirestore.instance;

  void addNewElement(){  
  // Upload payload
    var user = <String, dynamic>{
      "FechaActivo": Timestamp.now(),
      "FechaRegistro": Timestamp.now(),
      "IdContactos": generateLocalIdentifier(),
      "Serial": generateLocalIdentifier()
    };
    // Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) => debugPrint('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Future<void> fetchElement() async {
    List<String> outputList = [];
    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        String output = "${doc.id} => ${doc.data()}";
        debugPrint(output);
        outputList.add(output);
      }
    });
  }

  String generateLocalIdentifier() {
    return const Uuid().v8();
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
