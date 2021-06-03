import 'package:OEGlobal/model/response.dart';

class Subscription extends Data{
  final int id;
  final String title;
  final String price;
  bool selected;

  Subscription({this.id, this.title, this.price, this.selected = false});
}