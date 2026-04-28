import '../../features/settings/models/settings.dart';
import '../../features/athlete_rankings/models/rankings.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<Settings> settingsBox;
  late final Box<RankingEntry> rankingsBox;

  ObjectBox._create(this.store) {
    settingsBox = Box<Settings>(store);
    rankingsBox = Box<RankingEntry>(store);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "obx"));
    return ObjectBox._create(store);
  }

  List<RankingEntry> getRankings(RankingOptions options) {
    Condition<RankingEntry> condition = RankingEntry_.boat.equals(options.boat) &
        RankingEntry_.category.equals(options.category) &
        RankingEntry_.distance.equals(options.distance) &
        RankingEntry_.season.equals(options.season ?? 2026);

    if (options.division != null && options.division != "Tutti") {
      condition = condition & RankingEntry_.division.equals(options.division!);
    }

    final query = rankingsBox.query(condition).build();
    final results = query.find();
    query.close();
    return results;
  }

  void saveRankings(RankingOptions options, List<RankingEntry> newEntries) {
    Condition<RankingEntry> condition = RankingEntry_.boat.equals(options.boat) &
        RankingEntry_.category.equals(options.category) &
        RankingEntry_.distance.equals(options.distance) &
        RankingEntry_.season.equals(options.season ?? 2026);

    if (options.division != null && options.division != "Tutti") {
      condition = condition & RankingEntry_.division.equals(options.division!);
    }

    final query = rankingsBox.query(condition).build();
    final oldIds = query.findIds();
    query.close();
    
    rankingsBox.removeMany(oldIds);
    rankingsBox.putMany(newEntries);
  }
}
