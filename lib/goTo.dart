import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ListController.dart';

class GoTo extends StatelessWidget {
  Item item;
  GoTo(this.item);

  var headingController = TextEditingController();
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    headingController.text = item.heading;
    textController.text = item.text;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white70),
        title: Text(
          item.heading,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 23),
        ),
        backgroundColor: Colors.deepOrange[900],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Text(item.text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
        ),
      ),
    );
  }
}
