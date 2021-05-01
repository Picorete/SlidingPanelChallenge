import 'package:get/get.dart';

class MainController extends GetxController {
  var title = 'YHLQMDLG';
  var subtitle = 'Bad Bunny';
  var image = 'assets/images/person1.png';

  changeAlbum({String? title, String? subtitle, String? image}) {
    this.title = title ?? this.title;
    this.subtitle = subtitle ?? this.subtitle;
    this.image = image ?? this.image;
    update();
  }
}
