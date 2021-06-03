import 'package:OEGlobal/model/response.dart';

class Category extends Data{
  final int id;
  final String title;
  bool selected;

  Category({this.id, this.title, this.selected});
}