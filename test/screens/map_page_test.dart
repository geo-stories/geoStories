import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_stories/screens/map_page.dart';

void main() {

  Widget widget = MaterialApp(
    home: MapPage(),
  );

  testWidgets('no se muestran Markers si MapPage no tiene marcadores', (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    final markerOptions = tester.firstWidget(find.byType(MarkerLayerOptions)) as MarkerLayerOptions;

    expect(markerOptions.markers, isEmpty);
  });

  testWidgets('se muestra un Marker por cada marcador de MapPage', (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    final markerOptions = tester.firstWidget(find.byType(MarkerLayerOptions)) as MarkerLayerOptions;

    expect(markerOptions.markers, isNotEmpty);
  });
}