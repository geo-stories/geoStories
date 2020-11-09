
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geo_stories/models/user_dto.dart';

class UserService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore database = FirebaseFirestore.instance;

  static Future<UserCredential> login(String email, String password) async{
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        print('the user is' + user.toString());
      }
    });
    return userCredential;
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
          'avatarUrl': ''
        });

    return userID;
  }


  static Future<void> updateCurrentUserProfile(UserDTO userUpdate) async {
    final User user = auth.currentUser;
    String updateAvatarUrl;
    String updateUsername;

    if (userUpdate.username != null) {
      updateUsername = userUpdate.username;
    } else {
      updateUsername = user.displayName;
    }

    if (userUpdate.avatarUrl != null) {
      updateAvatarUrl = userUpdate.avatarUrl;
    } else {
      updateAvatarUrl = user.photoURL;
    }

    await user.updateProfile(
      displayName: updateUsername,
      photoURL: updateAvatarUrl
    );

    await user.reload();
  }

  static User getCurrentUser() {
    return auth.currentUser;
  }

  static bool isAnonymousUser(){
    return getCurrentUser() != null;
  }

}