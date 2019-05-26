

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:campus_virtual/src/services/CampusVirtual.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {

  final CampusVirtual _campusVirtual;

  LoginBloc(this._campusVirtual);

  var _controllerLogado = BehaviorSubject<bool>();
  Stream get outLogado => _controllerLogado.stream;

  void logar(String cpf, String senha) {
    _campusVirtual.logar(cpf, senha)
      .then((val) => _controllerLogado.add(val))
      .catchError((error) => _controllerLogado.add(error));
  }

  @override
  void dispose() {
    _controllerLogado.close();
  }
}