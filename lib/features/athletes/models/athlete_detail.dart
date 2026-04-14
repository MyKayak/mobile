import '../../teams/models/team_preview.dart';

class AthleteDetail {
  final int id;
  final String name;
  final String surname;
  final String birthDate;
  final TeamPreview? team;
  final List<PersonalRecord> personalRecords;
  final Map<String, List<TimeProgressionEntry>> timeProgression;

  AthleteDetail({
    required this.id,
    required this.name,
    required this.surname,
    required this.birthDate,
    this.team,
    required this.personalRecords,
    required this.timeProgression,
  });

  factory AthleteDetail.fromMap(Map<String, dynamic> map) {
    return AthleteDetail(
      id: map["id"] is String ? int.parse(map["id"]) : (map["id"] ?? 0),
      name: map["name"] ?? "",
      surname: map["surname"] ?? "",
      birthDate: map["birth_date"] ?? "",
      team: map["team"] != null ? TeamPreview.fromMap(map["team"]) : null,
      personalRecords: (map["personal_records"] as List? ?? [])
          .map((pr) => PersonalRecord.fromMap(pr))
          .toList(),
      timeProgression: (map["time_progression"] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(
                key,
                (value as List)
                    .map((entry) => TimeProgressionEntry.fromMap(entry))
                    .toList(),
              )),
    );
  }
}

class PersonalRecord {
  final String boat;
  final int distance;
  final String category;
  final int time;

  PersonalRecord({
    required this.boat,
    required this.distance,
    required this.category,
    required this.time,
  });

  factory PersonalRecord.fromMap(Map<String, dynamic> map) {
    return PersonalRecord(
      boat: map["boat"] ?? "",
      distance: map["distance"] ?? 0,
      category: map["category"] ?? "",
      time: map["time"] ?? 0,
    );
  }
}

class TimeProgressionEntry {
  final int timeMs;
  final String date;

  TimeProgressionEntry({
    required this.timeMs,
    required this.date,
  });

  factory TimeProgressionEntry.fromMap(Map<String, dynamic> map) {
    return TimeProgressionEntry(
      timeMs: map["time_ms"] ?? 0,
      date: map["date"] ?? "",
    );
  }
}
