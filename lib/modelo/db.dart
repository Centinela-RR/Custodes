import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirebaseConnection {
  final db = FirebaseFirestore.instance;

  void addNewElement() {
    // Upload payload
    var user = <String, dynamic>{
      "FechaActivo": Timestamp.now(),
      "FechaRegistro": Timestamp.now(),
      "IdContactos": generateLocalIdentifier(),
      "Serial": generateLocalIdentifier()
    };
    // Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        debugPrint('DocumentSnapshot added with ID: ${doc.id}'));
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

class UserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _verificationId = '';
  int? _resendToken = 0;

  Future<void> signInWithPhone({required String phoneNumber}) async {
    verificationCompleted(AuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
    }

    verificationFailed(FirebaseAuthException authException) {
      debugPrint('${authException.message}');
    }

    codeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
    }

    codeSent(String verificationId, int? resendToken) {
      // Almacenar el verificationId y resendToken
      _verificationId = verificationId;
      _resendToken = resendToken;
    }

    await _auth.verifyPhoneNumber(
      // Agregar +52 para limitar el acceso a gente de México
      phoneNumber: '+52$phoneNumber',
      // Expira en 60 segundos
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      forceResendingToken: _resendToken,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  String? uid() {
    return _auth.currentUser?.uid;
  }

  Future<bool> verifyPhoneCode({required String smsCode}) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );
    try {
      await _auth.signInWithCredential(credential);
      debugPrint('Should go to the next screen by now! Usuario: ${uid()}');
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}