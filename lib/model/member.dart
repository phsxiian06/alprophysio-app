import 'package:OEGlobal/model/response.dart';
import 'package:flutter/cupertino.dart';

class Member extends Data{
  final int id;
  final Color color;
  final String name;
  bool selected;

  Member({this.id, this.color, this.name, this.selected = false});
}