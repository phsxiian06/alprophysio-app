import 'package:OEGlobal/model/response.dart';

class Course extends Data{
  final int id;
  final String title;
  final String des;
  final String des1;
  final String des2;
  bool expanded;

  Course({this.id, this.title, this.des, this.des1, this.des2, this.expanded = false});
}