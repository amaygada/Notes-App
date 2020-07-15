//this is for test. NOT PART OF THE CODE

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:notesapp/store.dart';

import 'ListController.dart';
/*
class StackTest extends StatefulWidget {
  @override
  _StackTestState createState() => _StackTestState();
}

class _StackTestState extends StateMVC<StackTest> {
  static var headerList = List<String>();
  static var textList = List<String>();
  var store = StoreList(headerList, textList);

  setList() async {
    var a = await store.getSharedPref();
    headerList = a[0];
    textList = a[1];
  }

  clearList() async {
    store.clearSharedPref();
  }

  @override
  void initState() {
    super.initState();
    setList();
    //clearList();
  }

  @override
  Widget build(BuildContext context) {
    setList();
    print(' header ' + headerList.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notes',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepOrange[900],
        ),
        body: Stack(
          children: <Widget>[
            Container(padding: EdgeInsets.all(10.0), child: buildList()),
            Container(
              child: Align(
                alignment: Alignment.bottomRight,
                child: RaisedButton(
                  child: Text('save'),
                  onPressed: () {
                    setState(() {
                      store.addSharedPref('Heading', 'Abcd Efgh Ijkl ...');
                      //setList();
                    });
                  },
                ),
              ),
            )
          ],
        ));
  }

  Widget buildList() {
    var listView = ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(3.0),
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: InkWell(
            onTap: () {
              print('hello');
            },
            child: Card(
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: ListTile(
                  leading: Icon(Icons.event_note),
                  title: Text(
                    headerList[index],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  subtitle: Text(
                    textList[index],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: headerList.length,
      shrinkWrap: true,
    );
    return listView;
  }
}
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Todo {
  final String heading;
  final String text;

  Todo(this.text, this.heading);
}

Widget buildList(List<Todo> todos) {
  //print('buildList was Called');
  var listView = ListView.builder(
    itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.all(3.0),
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Card(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: ListTile(
              leading: Icon(Icons.event_note),
              title: Text(
                todos[index].heading,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              subtitle: Text(
                todos[index].text.length < 14
                    ? '${todos[index].text}'
                    : '${todos[index].text.substring(0, 14)}....',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(todo: todos[index]),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
    itemCount: todos.length,
  );
  return listView;
}

class TodoScreen extends StatefulWidget {
  final List<Todo> todos;
  TodoScreen({Key key, @required this.todos}) : super(key: key);
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: buildList(widget.todos),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Todo todo;

  var headingControllera = TextEditingController();
  var textControllera = TextEditingController();

  // In the constructor, require a Todo.
  DetailScreen({@required this.todo});

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(todo.heading, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text(todo.text),
      ),
    );
  }

  Widget editTextWidget(BuildContext context) {
    headingControllera.text = todo.heading;
    textControllera.text = todo.text;
    //print('I have enlarged');
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5.0),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(50.0)),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: TextField(
                    controller: headingControllera,
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
                      controller: textControllera,
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
                        'Back',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: Colors.deepOrange,
                    ),
                    FloatingActionButton.extended(
                      label: Hero(
                        tag: 'save 2',
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      onPressed: () {},
                      backgroundColor: Colors.deepOrange,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
