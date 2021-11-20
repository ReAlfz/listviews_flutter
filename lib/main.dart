import 'package:flutter/material.dart';
import 'package:listviews/list_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.getSytle,
      ),
      home: const Scaffold(
        body: List_Home(),
      ),
    );
  }
}

class Palette {
  static const MaterialColor getSytle = MaterialColor(
      0xFF50514F,
      <int, Color> {
        50: Color(0xff666666),//10%
        100: Color(0xff5C5C5C),//20%
        200: Color(0xff525252),//30%
        300: Color(0xff474847),//40%
        400: Color(0xff3D3E3D),//50%
        500: Color(0xff323432),//60%
        600: Color(0xff282A28),//70%
        700: Color(0xff1E1F1E),//80%
        800: Color(0xff141514),//90%
        900: Color(0xff0A0A0A),//100%
      }
  );
}