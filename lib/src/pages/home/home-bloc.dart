import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:campus_virtual/src/models/Materia.dart';
import 'package:campus_virtual/src/services/CampusVirtual.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {

  final CampusVirtual _campusVirtual;

  HomeBloc(this._campusVirtual);

  var _controllerMaterias = BehaviorSubject<List<Materia>>();
  Stream get outMaterias => _controllerMaterias.stream;

  void getMaterias() {
    _campusVirtual.getMaterias()
      .then((value) => _controllerMaterias.add(value))
      .catchError((error) => _controllerMaterias.addError(error));
  }

  @override
  void dispose() {
    _controllerMaterias.close();
  }
}