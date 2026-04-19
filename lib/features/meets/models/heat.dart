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
    final millis = time % 1000;
    final seconds = (time ~/ 1000) % 60;
    final minutes = (time ~/ 60000) % 60;
    final hours = (time ~/ 3600000) % 24;
    final days = time ~/ 86400000;

    final parts = <String>[
      if (days > 0) days.toString().padLeft(2, '0'),
      if (days > 0 || hours > 0) hours.toString().padLeft(2, '0'),
      minutes.toString().padLeft(2, '0'),
      '${seconds.toString().padLeft(2, '0')}.${millis.toString().padLeft(3, '0')}',
    ];

    return parts.join(':');
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
