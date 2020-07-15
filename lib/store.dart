import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class StoreList {
  List<String> path;
  List<String> duration;

  StoreList(this.path, this.duration);

  Future getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    path = prefs.getStringList('path') ?? List<String>();
    duration = prefs.getStringList('duration') ?? List<String>();
    List<List<String>> a = List<List<String>>();
    a.add(path);
    a.add(duration);
    return a ?? List<List<String>>();
  }

  clearSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('path', List<String>());
    prefs.setStringList('duration', List<String>());
  }

  addSharedPref(String pathString, String durationString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getSharedPref();
    path.add(pathString);
    duration.add(durationString);
    prefs.setStringList('path', path);
    prefs.setStringList('duration', duration);
  }

  static removeSharedPref(index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var p = prefs.getStringList('path');
    var d = prefs.getStringList('duration');
    p.removeAt(index);
    d.removeAt(index);
    prefs.setStringList('path', p);
    prefs.setStringList('duration', d);
  }
}
