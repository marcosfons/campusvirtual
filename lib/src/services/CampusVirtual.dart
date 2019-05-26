import 'package:campus_virtual/src/models/Materia.dart';
import 'package:campus_virtual/src/models/Pdf.dart';
import 'package:campus_virtual/src/models/Section.dart';
import 'package:campus_virtual/src/models/Usuario.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class CampusVirtual {

  Dio dio;
  Usuario usuario;

  static const String ORIGIN = 'https://www.campusvirtual.ufsj.edu.br';
  static const String URL_BASE = 'https://www.campusvirtual.ufsj.edu.br/portal/2019_1/';
  static const String ENDPOINT_LOGIN = 'login/index.php';
  static const String ENDPOINT_HOME = 'my/';
  static const String ENDPOINT_COURSES = 'lib/ajax/service.php';

  var GET_COURSE = [
    {
        'index': 0,
        'methodname': 'core_course_get_enrolled_courses_by_timeline_classification',
        'args': {
            'offset': 0,
            'limit': 48,
            'classification': 'all',
            'sort': 'fullname'
        }
    }
  ];

  CampusVirtual() {
    dio = Dio();
    dio.options.baseUrl = URL_BASE;
    dio.interceptors.add(CookieManager(CookieJar()));
  }

  Future<bool> logar(String cpf, String senha) async {
    usuario = Usuario(cpf, senha);
    var response = await dio.get(URL_BASE + ENDPOINT_LOGIN);

    usuario.logintoken = _getLoginToken(response.data);
    
    await dio.post(
      URL_BASE + ENDPOINT_LOGIN, 
      data: usuario.formDataLogin(),
      options: Options(followRedirects: false, validateStatus: (val) => val < 500)
    );
    return true;
  }

  Future<List<Materia>> getMaterias() async {
    var response = await dio.get(URL_BASE + ENDPOINT_HOME);

    String sessionKey = _getSessionKey(response.data);
    
    response = await dio.post('${URL_BASE + ENDPOINT_COURSES}?sesskey=$sessionKey&info=core_course_get_enrolled_courses_by_timeline_classification', data: GET_COURSE);
    
    return response.data[0]['data']['courses'].map((materia) => Materia.fromJson(materia)).toList().cast<Materia>();
  }

  Future<Materia> getMateriaPdfs(Materia materia) async {
    var response = await dio.get(materia.url);
    // print()
    // materia.sections = getSections(response.data);
    return materia;
  }

  Future<List<Section>> getSections(Materia materia) async {
    try {
      var response = await dio.get(materia.url);
      return parse(response.data)
        .getElementsByClassName('course-content')[0]
        .getElementsByClassName('topics')[0]
        .children.map((element) => Section.fromHtmlLi(element)).toList().cast<Section>();
    } catch(e) {
      throw(e.toString());
    }
  }

  String _getLoginToken(data) {
    return parse(data)
      .querySelectorAll('input')
      .singleWhere((input) => input.attributes['name'] == 'logintoken')
      .attributes['value'];
  }

  String _getSessionKey(data) {
    var sesskey = '';
    sesskey = data.substring(data.indexOf('sesskey') + 10);
    sesskey = sesskey.substring(0, sesskey.indexOf('"'));
    return sesskey;
  }

}