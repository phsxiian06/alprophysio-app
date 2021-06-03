import 'package:OEGlobal/model/response.dart';

class NotificationList extends Data{
  final int id;
  final String img;
  final String title;
  final String msg;
  final String date;
  final int type;
  final String typeName;
  bool read;

  NotificationList({this.id, this.img, this.title, this.msg, this.date, this.type, this.typeName, this.read = false});
}