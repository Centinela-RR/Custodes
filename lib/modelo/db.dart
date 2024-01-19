//import 'package:firebase_database/firebase_database.dart';

class FirebaseConnection {
//  final DatabaseReference _databaseReference =
//      FirebaseDatabase.instance.reference();

  Future<bool> testConnection() async {
    try {
      //await _databaseReference.child('.info').once();
      return true;
    } catch (e) {
      print('Firebase connection failed: $e');
      return false;
    }
  }
}
