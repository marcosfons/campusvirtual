import 'package:dio/dio.dart';

class Usuario {
  String cpf;
  String senha;
  String logintoken;

  Usuario(this.cpf, this.senha);

  Map<String, String> dataLogin() {
    return {
      'username': this.cpf,
      'password': this.senha,
      'rememberusername': '1',
      'anchor': '',
      'logintoken': this.logintoken
      // 'logintoken': '3MGALdnURDD2dmRsvDyPjEcJiIqRErSd'
    };
  }
  
  FormData formDataLogin() {
    return FormData.from({
      'username': this.cpf,
      'password': this.senha,
      'rememberusername': '1',
      'anchor': '',
      'logintoken': this.logintoken
    });
  }

}