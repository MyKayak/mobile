import 'package:flutter/foundation.dart';

@immutable
class RankingEntry {
  final int athleteId;
  final String athleteName;
  final String athleteSurname;
  final String birthDate;
  final int distance;
  final String category;
  final String division;
  final int bestTime;
  final int bestThreeAverage;
  final String boat;

  const RankingEntry(this.athleteId, this.athleteName, this.athleteSurname, this.birthDate, this.distance, this.category, this.division, this.bestTime, this.bestThreeAverage, this.boat);

  factory RankingEntry.fromMap(Map<String, dynamic> map) {
    return RankingEntry(
      map["athlete_id"] ?? 0,
      map["name"] ?? "John",
      map["surname"] ?? "Doe",
      map["birth_date"] ?? "1970-01-01",
      map["distance"] ?? 1000,
      map["category"] ?? "M",
      map["division"] ?? "SEN",
      ((map["best_time"] ?? 99999) as num).floor(),
      ((map["avg_best_3"] ?? 99999) as num).floor(),
      map["boat"] ?? "K1"
    );
  }
}

@immutable
class RankingOptions {
  final String category;
  final String? division;
  final int distance;
  final int? season;
  final String boat;

  const RankingOptions({
    required this.category,
    this.division,
    required this.distance,
    this.season,
    required this.boat,
  });

  RankingOptions copyWith({
    String? category,
    String? division,
    int? distance,
    int? season,
    String? boat,
  }) {
    return RankingOptions(
      category: category ?? this.category,
      division: division ?? this.division,
      distance: distance ?? this.distance,
      season: season ?? this.season,
      boat: boat ?? this.boat,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RankingOptions &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          division == other.division &&
          distance == other.distance &&
          season == other.season &&
          boat == other.boat;

  @override
  int get hashCode =>
      category.hashCode ^
      division.hashCode ^
      distance.hashCode ^
      season.hashCode ^
      boat.hashCode;
}
