import 'package:flutter/material.dart';
import 'package:notesapp/NotesView.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new Notes(),
        title: new Text(
          'NOTES',
          style: new TextStyle(
              color: Colors.deepOrange[900],
              fontWeight: FontWeight.w600,
              fontSize: 35.0),
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        image: Image.asset('assets/images/note.png'),
        photoSize: 50,
        loaderColor: Colors.transparent,
      ),
    );
  }
}
