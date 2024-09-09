import 'package:binarytranslate/pages/motarjem.dart';
import 'package:get/get.dart';
String res = '';
class rescontroller extends GetxController {
  
  String get getres => res;

  void resupdate() {
    res = matn;
    update();
  }
}
