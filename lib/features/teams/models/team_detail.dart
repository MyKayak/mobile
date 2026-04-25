class TeamDetail {
  final String id;
  final String name;
  final String? logo;
  final List<TeamTitle> titles;

  TeamDetail({
    required this.id,
    required this.name,
    this.logo,
    required this.titles,
  });

  factory TeamDetail.fromMap(Map<String, dynamic> map) {
    return TeamDetail(
      id: map["team_id"] ?? map["id"] ?? "",
      name: map["name"] ?? "",
      logo: map["logo"],
      titles: (map["titles"] as List? ?? [])
          .map((title) => TeamTitle.fromMap(title))
          .toList(),
    );
  }
}

class TeamTitle {
  final int timeMs;
  final String startTime;
  final int distance;
  final String category;
  final String division;
  final String boat;
  final String location;

  TeamTitle({
    required this.timeMs,
    required this.startTime,
    required this.distance,
    required this.category,
    required this.division,
    required this.boat,
    required this.location,
  });

  factory TeamTitle.fromMap(Map<String, dynamic> map) {
    return TeamTitle(
      timeMs: map["time_ms"] ?? 0,
      startTime: map["date"] ?? "",
      distance: map["distance"] ?? 0,
      category: map["category"] ?? "",
      division: map["division"] ?? "",
      boat: map["boat"] ?? "",
      location: map["location"] ?? "",
    );
  }
}
