import '../../features/settings/models/settings.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<Settings> settingsBox;

  ObjectBox._create(this.store) {
    settingsBox = Box<Settings>(store);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "obx"));
    return ObjectBox._create(store);
  }
}
