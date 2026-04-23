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
      map["team_id"] as String, 
      map["team_name"] as String,
      _toInt(map["gold"]),
      _toInt(map["silver"]),
      _toInt(map["bronze"]),
      _toInt(map["total_medals"])
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}

class MedalTableOptions {
  final int? season;
  final bool onlyChampionships;

  const MedalTableOptions({
    this.season,
    this.onlyChampionships = false,
  });

  MedalTableOptions copyWith({
    int? season,
    bool? onlyChampionships,
  }) {
    return MedalTableOptions(
      season: season ?? this.season,
      onlyChampionships: onlyChampionships ?? this.onlyChampionships,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedalTableOptions &&
          runtimeType == other.runtimeType &&
          season == other.season &&
          onlyChampionships == other.onlyChampionships;

  @override
  int get hashCode => season.hashCode ^ onlyChampionships.hashCode;
}
