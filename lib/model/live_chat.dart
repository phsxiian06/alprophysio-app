import 'package:OEGlobal/model/response.dart';

class LiveChat extends Data{
  final int id;
  final String img;
  final String name;
  final String msg;

  LiveChat({this.id, this.img, this.name, this.msg});
}