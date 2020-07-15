import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:notesapp/goTo.dart';
import 'package:notesapp/store.dart';

class ListController extends AppConMVC {
  factory ListController() {
    if (_this == null) _this = ListController._();
    return _this;
  }
  static ListController _this;
  ListController._();
  static ListController get getCon => _this;

  Widget buildList(List<String> text, List<String> header) {
    print('list $header');
    var a = generateItems(text.length, text, header);
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
                trailing: InkWell(
                  onTap: () {
                    StoreList.removeSharedPref(index);
                    setState(() {});
                  },
                  child: Icon(
                    Icons.delete,
                    size: 27,
                    color: Colors.red[300],
                  ),
                ),
                title: Text(
                  a[index].heading,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                subtitle: Text(
                  a[index].text.length < 14
                      ? '${a[index].text}'
                      : '${a[index].text.substring(0, 14)}....',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GoTo(a[index])));
                },
              ),
            ),
          ),
        );
      },
      itemCount: text.length,
    );
    return listView;
  }
}

class Item {
  String heading;
  String text;

  Item(this.heading, this.text);
}

List<Item> generateItems(int length, List<String> text, List<String> heading) {
  var a = List.generate(length, (index) => Item(heading[index], text[index]));
  return a;
}
