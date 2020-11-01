
import 'package:geo_stories/models/user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static FirebaseAuth auth = FirebaseAuth.instance;
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
  }

  static Future<void> register() async{
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: "woody.allen@example.com",
        password: "SuperSecretPassword!"
    );
    return userCredential;
  }



}