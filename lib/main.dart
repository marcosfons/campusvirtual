import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'src/pages/home/home-bloc.dart';
import 'src/pages/home/home-page.dart';
import 'src/pages/login/login-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => HomeBloc())
      ],
      child: MaterialApp(
        title: 'Campus Virtual',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}
