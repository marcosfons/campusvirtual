import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:campus_virtual/src/models/Materia.dart';
import 'package:campus_virtual/src/pages/materia/materia-page.dart';
import 'package:flutter/material.dart';

import 'home-bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final HomeBloc bloc = BlocProvider.getBloc<HomeBloc>();
  
  @override
  void initState() {
    super.initState();
    bloc.getMaterias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus Virtual'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.update),
            onPressed: bloc.getMaterias,
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
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MateriaPage(materia: snapshot.data[index]) )),
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