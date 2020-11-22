import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future MarkersMockerDataHelper(FirebaseFirestore instance, FirebaseAuth auth) async {
  await instance.collection('markers')
      .add({
    'latitude': -34.6001014,
    'longitude': -58.3824443,
    'title' : "prueba",
    'description' : "description",
    'likes': [],
    'owner': auth.currentUser.uid
  });
}

Future MarkersMockerDataHelperWithDescription(FirebaseFirestore instance, String oldDescription, FirebaseAuth auth) async {
  await instance.collection('markers')
      .add({
    'latitude': -34.6001014,
    'longitude': -58.3824443,
    'title' : "prueba",
    'description' : oldDescription,
    'likes': [],
    'owner': auth.currentUser.uid
  });
}