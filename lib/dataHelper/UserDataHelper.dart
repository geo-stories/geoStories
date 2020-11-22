import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future UsuariosMockerDataHelper(FirebaseFirestore instance, FirebaseAuth auth) async {
  await instance.collection('users').doc(auth.currentUser.uid).set({
    'username' : "sarasa"
  });
}