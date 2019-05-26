

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:campus_virtual/src/models/Materia.dart';
import 'package:campus_virtual/src/services/CampusVirtual.dart';
import 'package:flutter/material.dart';

import 'materia-bloc.dart';

class MateriaPage extends StatefulWidget {
  final Materia materia;
  const MateriaPage({Key key, this.materia}) : super(key: key);
  @override
  _MateriaPageState createState() => _MateriaPageState();
}

class _MateriaPageState extends State<MateriaPage> {
  
  MateriaBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = MateriaBloc(BlocProvider.getDependency<CampusVirtual>(), widget.materia);
    bloc.getPdfsMateria();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Materia>(
      stream: bloc.outMateria,
      initialData: widget.materia,
      builder: (BuildContext context, AsyncSnapshot<Materia> snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data.sections != null){
            if(snapshot.data.sections.length != 0)
              return Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data.fullname),
                ),
                body: ListView.builder(
                  itemCount: snapshot.data.sections.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                      title: Text(snapshot.data.sections[index].name),
                      children: snapshot.data.sections[index].pdfs.map<Widget>((pdf) {
                        return ListTile(
                          title: Text(pdf.instancename),
                          leading: Text('PDF', style: TextStyle(color: Color.fromRGBO(192, 38, 46, 1), fontSize: 12)),
                        );
                      }).toList(),
                    );
                  },
                ),
              );
            if(snapshot.data.sections.length == 0) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data.fullname),
                ),
                body: Center(child: Text('Sem pdfs brow'),),
              );
            }
          }
        } else if(snapshot.hasError) {
          // if(snapshot.;)
          print(snapshot.hasData);
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.materia.fullname),
            ),
            body: Center(child: Text('Erro brow ${snapshot.error.toString()}'),)
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data.fullname),
          ),
          body: Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}