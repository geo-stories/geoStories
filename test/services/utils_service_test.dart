import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/services/utils_service.dart';

void main() {

  setUp(() async {

  });


  test('generateFirestoreId genera un string aleatorio de 20 caracteres', () async {
    // Es imposible validar que un id siempre se va a generar aleatoriamente,
    // y hacer que este test sea mas deterministicamente seguro es caro
    // para la herramienta de CI y retrasaria el build, asi que se minimamente
    // se valida que esta generando ids aleatorios y nunca genera el mismo
    var firebaseId1 = UtilsService.generateFirestoreId();
    var firebaseId2 = UtilsService.generateFirestoreId();
    var firebaseId3 = UtilsService.generateFirestoreId();

    assert((firebaseId1 != firebaseId2) && (firebaseId2 != firebaseId3) && (firebaseId3 != firebaseId1));

    assert(firebaseId1.length == 20);
    assert(firebaseId2.length == 20);
    assert(firebaseId3.length == 20);
  });
}