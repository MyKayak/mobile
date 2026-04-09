import 'package:objectbox/objectbox.dart';

@Entity()
class Settings {
  @Id()
  int id = 0;

  String serverIp;

  Settings({this.id = 0, this.serverIp='api.mykayak.fuffo.net'});
}
