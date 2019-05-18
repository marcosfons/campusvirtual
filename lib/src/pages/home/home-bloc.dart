import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:campus_virtual/src/models/Materia.dart';
import 'package:campus_virtual/src/services/CampusVirtual.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {

  CampusVirtual _campusVirtual = CampusVirtual();

  var _controllerMaterias = BehaviorSubject<List<Materia>>();
  Stream get outMaterias => _controllerMaterias.stream;

  void logar(String cpf, String senha) {
    _campusVirtual.getMaterias(cpf, senha)
      .then((value) => _controllerMaterias.add(value))
      .catchError((error) => _controllerMaterias.addError(error));
  }

  @override
  void dispose() {
    _controllerMaterias.close();
  }
}