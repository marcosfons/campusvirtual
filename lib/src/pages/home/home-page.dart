import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:campus_virtual/src/models/Materia.dart';
import 'package:flutter/material.dart';

import 'home-bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = BlocProvider.getBloc<HomeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus Virtual'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.update),
            onPressed: () => bloc.logar('09683282610', '09683282610'),
          )
        ],
      ),
      body: StreamBuilder<List<Materia>>(
        stream: bloc.outMaterias,
        builder: (BuildContext context, AsyncSnapshot<List<Materia>> snapshot) {
          if(snapshot.hasData)
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].fullname),
                );
              },
            );
          else if(snapshot.hasError)
            return Center(
              child: Text('Erro: ${snapshot.error.toString()}'),
            );
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}