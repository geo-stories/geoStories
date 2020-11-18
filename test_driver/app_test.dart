import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('GeoStories App', () {
    final ingresarAnonimoFinder = find.byValueKey('Ingresar como Anon');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

  test('el texto de ingresar anónimo existe', () async {
      final textoIngresarAnonimoFinder = find.descendant(
          of: ingresarAnonimoFinder,
          matching: find.descendant(
              of: find.byType('FlatButton'), matching: find.byType('Text')));

      expect(await driver.getText(textoIngresarAnonimoFinder), "Ingresar como Anónimo");
    });

    test('se llega al botón de crear marker por medio de ingresar anónimo', () async {
      await driver.tap(ingresarAnonimoFinder);

      final crearMarkerFinder = find.byValueKey('boton-crear-marker');
      expect(crearMarkerFinder, isNotNull);
    });

  });
}