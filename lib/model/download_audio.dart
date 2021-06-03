import 'package:OEGlobal/model/response.dart';

class DownloadAudio extends Data{
  final int id;
  final String img;
  final String name;
  final String author;

  DownloadAudio({this.id, this.img, this.name, this.author});
}