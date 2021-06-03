import 'package:OEGlobal/model/response.dart';

class OGRecord extends Data{
  final int id;
  final String title;
  final String date;
  final String amount;
  bool earn;

  OGRecord({this.id, this.title, this.date, this.amount, this.earn = false});
}