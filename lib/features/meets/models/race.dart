class Race {
  final int id;
  final String code;
  final int distance;
  final String division;
  final String category;
  final String boat;
  final String level;

  Race(this.id, this.code, this.distance, this.division, this.category, this.boat, this.level);

  factory Race.fromMap(Map<String, dynamic>map){
    return Race(
      map["id"],
      map["code"],
      map["distance"],
      map["division"],
      map["category"],
      map["boat"],
      map["level"],
    );
  }
}
