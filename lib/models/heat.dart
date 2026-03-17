class Heat {
  int id;
  int index;
  String startTime;
  List<Performance> perfomances;

  Heat(this.id, this.index, this.startTime, this.perfomances);
}

class Performance {
  int lane;
  int placement;
  String teamId;
  String teamName;
  int time;
  String status;
  int points;
  List<Athlete> athletes;

  Performance(this.lane, this.placement, this.teamId, this.teamName, this.time, this.status, this.points, this.athletes);

  String get timeLabel {
    return ""; // TODO: implement
  }
}

class Athlete {
  String name;
  String surname;
  String birthDate;

  Athlete(this.name, this.surname, this.birthDate);
}
