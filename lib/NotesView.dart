import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:notesapp/ListController.dart';
import 'package:notesapp/store.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends StateMVC<Notes> with TickerProviderStateMixin {
  Animation animationWidth, transformationAnim, animationHeight;
  AnimationController animationController;
  final headingController = TextEditingController();
  final textController = TextEditingController();
  var count;
  bool saved = false;

  _NotesState() : super(ListController()) {
    String id2 = add(ListController.getCon);
    listHandler = controllerById(id2);
    listHandler = controller;
  }

  ListController listHandler;
  static List<String> headerList = List<String>();
  static List<String> textList = List<String>();
  var listt = List<List<String>>();

  var store = StoreList(headerList, textList);

  @override
  void initState() {
    super.initState();
    count = 0;
    setList();
    //clearList();
  }

  clearList() {
    store.clearSharedPref();
  }

  Future setList() async {
    listt = await store.getSharedPref();
    return listt;
  }

  @override
  Widget build(BuildContext context) {
    //print('mainBuildMethod');
    count == 0 ? initAnimation() : null;
    print('build $headerList ');

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Notes',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepOrange[900],
        ),
        body: Stack(
          children: <Widget>[
            FutureBuilder(
              future: setList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(child: Center(child: Text('Loading...')));
                } else {
                  return Container(
                    color: Colors.white,
                    child: listt == null
                        ? () {
                            setState(() {});
                          }
                        : Center(
                            child: listHandler.buildList(
                                snapshot.data[1], snapshot.data[0]),
                          ),
                  );
                }
              },
            ),
            AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget child) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          if (count == 0) {
                            //print('tapped and count = 0');
                            animationController.forward();
                            count = count + 1;
                            //print('now count = 1');
                          }
                        },
                        child: Opacity(
                          opacity: 1,
                          child: Container(
                              width: animationWidth.value,
                              height: animationHeight.value,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: transformationAnim.value),
                              child: selectView(
                                context,
                                MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height,
                                animationHeight.value,
                              )),
                        ),
                      )),
                );
              },
            )
          ],
        ));
  }

  Widget selectView(
      BuildContext context, double width, double height, animationHeightValue) {
    if (animationHeightValue == MediaQuery.of(context).size.height) {
      return editTextWidget(width, height, context);
    } else if (animationHeightValue > 70) {
      return Icon(
        Icons.add,
        color: Colors.black87,
        size: 1,
      );
    } else {
      return iconWidget();
    }
  }

  Widget iconWidget() {
    //print('I am still small');
    return Icon(Icons.add, color: Colors.white);
  }

  Widget editTextWidget(width, height, context) {
    //print('I have enlarged');
    setList();
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: TextField(
                  controller: headingController,
                  textAlign: TextAlign.center,
                  maxLength: 19,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Heading',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: TextField(
                    controller: textController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                    decoration: InputDecoration.collapsed(
                        hintText: 'Notes...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w300)),
                  ),
                )),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton.extended(
                    label: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {
                      //print('cancel Pressed');
                      setState(() {
                        count = 0;
                      });
                      //print('now cancel count = 0');
                    },
                    backgroundColor: Colors.deepOrange,
                  ),
                  FloatingActionButton.extended(
                    label: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {
                      if (headingController.text != '' &&
                          textController.text != '') {
                        //print('save pressed');
                        setState(() {
                          count = 0;
                          //print('now saved count = 0');
                          store.addSharedPref(
                              headingController.text, textController.text);

                          //print('added to list');
                          textController.text = '';
                          headingController.text = '';
                        });
                      } else {}
                    },
                    backgroundColor: Colors.deepOrange,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void initAnimation() {
    //print('animation data has been initialized');
    animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    animationWidth = Tween(begin: 60.0, end: MediaQuery.of(context).size.width)
        .animate(CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 1.0, curve: Curves.ease)));

    animationHeight =
        Tween(begin: 60.0, end: MediaQuery.of(context).size.height).animate(
            CurvedAnimation(
                parent: animationController,
                curve: Interval(0.0, 1.0, curve: Curves.ease)));

    transformationAnim = BorderRadiusTween(
            begin: BorderRadius.circular(30.0),
            end: BorderRadius.circular(50.0))
        .animate(CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 1.0, curve: Curves.ease)));
  }

  @override
  void dispose() {
    textController.dispose();
    headingController.dispose();
    super.dispose();
  }
}
