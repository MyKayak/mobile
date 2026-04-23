import '../../../core/utils/time_formatter.dart';

class Heat {
  int id;
  int index;
  String startTime;
  List<Performance> performances;

  Heat(this.id, this.index, this.startTime, this.performances);

  factory Heat.fromMap(Map<String, dynamic> map) {
    return Heat(
      map["id"],
      map["index"],
      map["start_time"],
      (map["performances"] as List)
          .map((performance) => Performance.fromMap(performance))
          .toList(),
    );
  }
}

class Performance {
  int lane;
  int placement;
  String teamId;
  String teamName;
  int time;
  String status;
  List<Athlete> athletes;

  Performance(
    this.lane,
    this.placement,
    this.teamId,
    this.teamName,
    this.time,
    this.status,
    this.athletes,
  );

  String get timeLabel {
    if (status.isNotEmpty && status != "OK") return status;
    return TimeFormatter.formatTime(time);
  }

  factory Performance.fromMap(Map<String, dynamic> map) {
    return Performance(
      map["lane"],
      map["placement"],
      map["team_id"],
      map["team_name"],
      map["time_ms"] ?? 0,
      map["status"] ?? "",
      (map["athletes"] as List)
          .map((athlete) => Athlete.fromMap(athlete))
          .toList(),
    );
  }
}

class Athlete {
  String name;
  String surname;
  String birthDate;

  Athlete(this.name, this.surname, this.birthDate);

  factory Athlete.fromMap(Map<String, dynamic> map) {
    return Athlete(map["name"], map["surname"], map["birth_date"]);
  }
}
