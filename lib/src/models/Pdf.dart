

import 'package:html/dom.dart';

class Pdf {
  String instancename;
  String linkDownload;

  Pdf(this.instancename, this.linkDownload);

  Pdf.fromHtmlLi(Element element) {
    try {
    this.instancename = element.getElementsByClassName('instancename')[0].text;
    } catch(e) {
      this.instancename = '';
      // print(e.toString());
    }
    try {
    this.linkDownload = element.querySelector('a').attributes['href'];
    } catch(e) {
      // print(e.toString());
      this.linkDownload = '';
    }
  }

}