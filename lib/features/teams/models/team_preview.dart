class TeamPreview {
  final String id;
  final String name;
  final String logo;

  TeamPreview(this.id, this.name, this.logo);

  factory TeamPreview.fromMap(Map<String, dynamic> map){
    return TeamPreview(
      map["team_id"] ?? map["id"] ?? "",
      map["name"] ?? "",
      map["logo"] ?? ""
    );
  }
}