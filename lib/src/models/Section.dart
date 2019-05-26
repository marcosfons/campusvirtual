import 'package:html/dom.dart';

import 'Pdf.dart';

class Section {
  String name;
  List<Pdf> pdfs = [];

  Section.fromHtmlLi(Element element) {
    this.name = element.attributes['aria-label'];
    // print(this.name);
    this.pdfs = element.getElementsByClassName('section')[0].children.map((element) => Pdf.fromHtmlLi(element)).toList().cast<Pdf>();
    // this.pdfs.forEach((pdf) => print('${pdf.instancename}'));
  }

}