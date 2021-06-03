import 'package:OEGlobal/model/response.dart';

class Purchased extends Data{
  final int id;
  final String img;
  final String name;
  final int type;
  final String typeName;
  final String author;
  final String price;
  final String date;
  final bool purchased;
  final String orderId;

  Purchased({this.id, this.img, this.name, this.type, this.typeName, this.author, this.price, this.date, this.purchased = false, this.orderId});
}