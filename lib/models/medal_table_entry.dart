class MedalTableEntry {
  String teamId;
  String teamName;
  int golds;
  int silvers;
  int bronzes;
  int total;

  MedalTableEntry(this.teamId, this.teamName, this.golds, this.silvers, this.bronzes, this.total);
  
  factory MedalTableEntry.fromMap(Map<String, dynamic> map){
    return MedalTableEntry(
      map["team_id"], 
      map["team_name"],
      int.parse(map["gold"]),
      int.parse(map["silver"]),
      int.parse(map["bronze"]),
      map["total_medals"]
    );
  }
}
