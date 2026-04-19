class RankingEntry {
  final int athleteId;
  final String athleteName;
  final String athleteSurname;
  final String birthDate;
  final String distance;
  final String category;
  final String division;
  final int bestTime;
  final int bestThreeAverage;
  final String boat;

  RankingEntry(this.athleteId, this.athleteName, this.athleteSurname, this.birthDate, this.distance, this.category, this.division, this.bestTime, this.bestThreeAverage, this.boat);

  factory RankingEntry.fromMap(Map<String, dynamic> map) {
    return RankingEntry(
      map["athlete_id"],
      map["name"],
      map["surname"],
      map["birth_date"],
      map["distance"],
      map["category"],
      map["division"],
      map["best_time"],
      map["avg_best_3"],
      map["boat"],
    );
  }
}

class RankingOptions {
  String category;
  String? division;
  String distance;
  int? season;
  String boat;

  RankingOptions({required this.category, this.division, required this.distance, this.season, required this.boat});
}
