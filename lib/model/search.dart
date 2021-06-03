import 'package:OEGlobal/model/response.dart';

class Search extends Data{
  final int id;
  final String title;
  bool active;
  final String type;

  Search({this.id, this.title, this.active = false, this.type});
}