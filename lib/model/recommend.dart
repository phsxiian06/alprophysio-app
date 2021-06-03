import 'package:OEGlobal/model/response.dart';

class Recommend extends Data{
  final int id;
  final String img;
  final String name;
  int type;
  String typeName;
  final String author;
  final String des;
  final String price;
  final int people;

  Recommend({this.id, this.img, this.name, this.type, this.typeName, this.author, this.des, this.price, this.people});
}