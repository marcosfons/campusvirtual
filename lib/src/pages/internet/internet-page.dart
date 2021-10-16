import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:html/parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InternetPage extends StatefulWidget {
  @override
  _InternetPageState createState() => _InternetPageState();
}

class _InternetPageState extends State<InternetPage> {
  
  static const String url = 'http://gstatic.com/generate_204';

  String _username = '';
  String _password = '';

  void logar() async {
    var r = await http.get(url);
    final String link = r.body.substring(r.body.indexOf('location="') + 10, r.body.indexOf('";'));
    var data = {};
    http.get(link).then((r) {
      var inputs = parse(r.body).getElementsByTagName('input');
      data = {'username': _username, 'password': _password};
      data[inputs[0].attributes['name']] = inputs[0].attributes['value'];
      data[inputs[1].attributes['name']] = inputs[1].attributes['value'];
    }).whenComplete(() async {
      http.post(link, body: data);
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logando na internet'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: logar,
          child: Text('logar'),
        ),
      ),
    );
  }
}