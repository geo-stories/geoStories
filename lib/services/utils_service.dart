import 'package:randombytes/randombytes.dart';

class UtilsService {

  // Firebase no expone un metodo para generar un Id de nuestro lado, pero el metodo
  // estaba open sourceado en el repositorio de firestore
  // https://github.com/googleapis/nodejs-firestore/blob/4f4574afaa8cf817d06b5965492791c2eff01ed5/dev/src/util.ts#L52
  static String generateFirestoreId() {
    final chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var firestoreId = '';

    while(firestoreId.length < 20) {
      final bytes = randomBytes(40);
      bytes.forEach((byte) {
        // Length of `chars` is 62. We only take bytes between 0 and 62*4-1
        // (both inclusive). The value is then evenly mapped to indices of `char`
        // via a modulo operation.
        final maxValue = 62 * 4 - 1;
        if (firestoreId.length < 20 && byte <= maxValue) {
          firestoreId += chars[byte % 62];
        }
      });
    }

    return firestoreId;
  }
}
