import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_stories/screens/welcome_page.dart';

import 'constants.dart';

Future<void> main() async {
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, 'assets/icons/geostories-logo.svg'), null);
  runApp(MyApp());
}

  Widget buildError(BuildContext context, FlutterErrorDetails error) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        children: [
          SizedBox(height: 100.0),
          Image.asset(kErrorFlutter, scale: 5,),
          SizedBox(height: 50.0),
          Center(
            child: Text("Se ha producido un error inesperado. 😨", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Text(error.exceptionAsString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),),
          ),
          //Image.asset('images/pic3.jpg'),
        ],
      ),
    );
  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoStories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return buildError(context, errorDetails);
        };
        return widget;
      },
      home: WelcomePage(),
    );
  }
}