import 'package:flutter/foundation.dart';
import 'package:objectbox/objectbox.dart';
import '../../../core/utils/time_formatter.dart';

@Entity()
class RankingEntry {
  @Id()
  int id = 0;

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
  final int season;

  RankingEntry({
    this.id = 0,
    required this.athleteId,
    required this.athleteName,
    required this.athleteSurname,
    required this.birthDate,
    required this.distance,
    required this.category,
    required this.division,
    required this.bestTime,
    required this.bestThreeAverage,
    required this.boat,
    required this.season,
  });

  String get timeLabel => TimeFormatter.formatTime(bestTime);
  String get avgLabel => TimeFormatter.formatTime(bestThreeAverage);

  factory RankingEntry.fromMap(Map<String, dynamic> map, int season) {
    return RankingEntry(
      athleteId: map["athlete_id"] ?? 0,
      athleteName: map["name"] ?? "John",
      athleteSurname: map["surname"] ?? "Doe",
      birthDate: map["birth_date"] ?? "1970-01-01",
      distance: map["distance"] ?? 1000,
      category: map["category"] ?? "M",
      division: map["division"] ?? "SEN",
      bestTime: ((map["best_time"] ?? 99999) as num).floor(),
      bestThreeAverage: ((map["avg_best_3"] ?? 99999) as num).floor(),
      boat: map["boat"] ?? "K1",
      season: season,
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
