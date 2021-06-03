import 'package:OEGlobal/model/response.dart';

class Voucher extends Data{
  final int id;
  final String img;
  final String title;
  final int type;
  final String typeName;
  final String des;
  final String date;
  bool expired;

  Voucher({this.id, this.img, this.title, this.type, this.typeName, this.des, this.date, this.expired = false});
}