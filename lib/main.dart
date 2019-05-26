import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'src/pages/home/home-bloc.dart';
import 'src/pages/internet/internet-page.dart';
import 'src/pages/login/login-bloc.dart';
import 'src/pages/login/login-page.dart';
import 'src/services/CampusVirtual.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
        ..maxConnectionsPerHost = 5;
  }
}

void main() { 
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      dependencies: [
        Dependency((i) => CampusVirtual())
      ],
      blocs: [
        Bloc((i) => HomeBloc(i.getDependency<CampusVirtual>())),
        Bloc((i) => LoginBloc(i.getDependency<CampusVirtual>())),
      ],
      child: MaterialApp(
        title: 'Campus Virtual',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InternetPage(),
      ),
    );
  }
}
