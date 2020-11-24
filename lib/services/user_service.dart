
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geo_stories/models/user_dto.dart';

class UserService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore database = FirebaseFirestore.instance;

  static Future<String> login(String email, String password) async{
    String errorMessage;

    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch  (e) {
      switch (e.code){
        case "invalid-email":
          errorMessage = "Tu email esta mal formado. 😥";
          break;
        case "user-not-found":
          errorMessage = "Usuario no encontrado. 😥";
          break;
        case "wrong-password":
          errorMessage = "La contraseña no es valida. 😥";
          break;
        default:
          errorMessage = "Hubo un error inesperado: + ${e.code}";
          print('Failed with error code: ${e.code}');
          print(e.message);
      }
    }
    return errorMessage;
  }

  static Future<void> register(String email, String password, String userName) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      await userCredential.user.updateProfile(displayName: userName);

      String userID = userCredential.user.uid;
      await database.collection("users")
          .doc(userID)
          .set({
        'username': userName,
        'avatarUrl': ''
      });
    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case 'invalid-email':
          throw 'No introdujiste un mail válido';
          break;
        default:
          throw e.message;
      }
    }

  }

  static Future<void> updateCurrentUserProfile(UserDTO userUpdate) async {
    try{
      updateUsernameAndAvatar(userUpdate);

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
    catch(e){
      print(e);
    }

  }

  static updateUsernameAndAvatar(UserDTO userUpdate){
    database.collection("users").doc(GetUserId()).update({
      'username' : userUpdate.username,
      'avatarUrl' : userUpdate.avatarUrl,
    });
  }

  static User getCurrentUser() {
    return auth.currentUser;
  }

  static bool isAnonymousUser(){
    return getCurrentUser() == null;
  }

  static void disconnect(){
    auth.signOut();
  }

  static Future<String> updatePassword(String newPassword) async {
    String errorMessage;

    try{
      final User user = auth.currentUser;
      await user.updatePassword(newPassword);
      await user.reload();
    } on FirebaseAuthException catch  (e) {
      switch (e.code){
        case "weak-password":
          errorMessage = "Tu nueva contraseña es demasiado corta. 😥";
          break;
        default:
          errorMessage = "Hubo un error inesperado: + ${e.code}";
          print('Failed with error code: ${e.code}');
          print(e.message);
      }
    }
    return errorMessage;
  }

  static String GetUsername(){
    return getCurrentUser().displayName;
  }

  static String GetUserId(){
    return getCurrentUser().uid;
  }

  static bool isMarkerOwner(String markerOwner){
    if(!isAnonymousUser()){
      return getCurrentUser().uid == markerOwner;
    }
    return false;
  }

  static Future<DocumentSnapshot> getUserByID(String uid) {
    Future<DocumentSnapshot> ref = database.collection("users").doc(uid).get();
    return  ref;
  }
}