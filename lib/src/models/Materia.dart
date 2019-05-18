import 'dart:typed_data';

class Materia {
  int id;
  String fullname;
  String shortname;
  int startdate;
  String url;
  Uint8List imagem;

  Materia.fromJson(Map json) {
    this.id = json['id'];
    this.fullname = json['fullname'];
    this.shortname = json['shortname'];
    this.startdate = json['startdate'];
    this.url = json['viewurl'];
    // debugPrint(json['courseimage']);
    // this.imagem = Base64Decoder().convert(Uri.parse(json['courseimage'].toString()).da);
    this.imagem = Uri.parse(json['courseimage'].toString()).data.contentAsBytes();
  }

}