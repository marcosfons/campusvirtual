import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:campus_virtual/src/models/Materia.dart';
import 'package:campus_virtual/src/services/CampusVirtual.dart';
import 'package:rxdart/rxdart.dart';

class MateriaBloc extends BlocBase {

  final CampusVirtual _campusVirtual;
  
  var _controllerMateria;
  Stream get outMateria => _controllerMateria.stream;

  MateriaBloc(this._campusVirtual, Materia materia) {
    _controllerMateria = BehaviorSubject<Materia>.seeded(materia);
  }

  void getPdfsMateria() {
    _campusVirtual.getSections(_controllerMateria.value)
      .then((value) {
        _controllerMateria.value.sections = value;
        _controllerMateria.add(_controllerMateria.value);
      })
      .catchError((error) => _controllerMateria.addError(error));
  }


  @override
  void dispose() {
    _controllerMateria.close();
  }
}