
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_stories/models/user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore database = FirebaseFirestore.instance;
/*FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });*/

  static Future<void> login(String email, String password) async{
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return UserCredential;
  }

  static Future<void> register(String email, String password, String userName) async{
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    String userID = userCredential.user.uid;

    await database.collection("users")
        .doc(userID)
        .set({
          'username': userName,
          'avatar': ''
        });

    return userID;
  }
}