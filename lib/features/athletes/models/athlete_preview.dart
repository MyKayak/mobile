class AthletePreview {
  final int id;
  final String name;
  final String surname;
  final String birthDate;

  AthletePreview(this.id, this.name, this.surname, this.birthDate);

  factory AthletePreview.fromMap(Map<String, dynamic> map) {
    return AthletePreview(
      map["athlete_id"] ?? map["id"] ?? 0,
      map["name"] ?? "",
      map["surname"] ?? "",
      map["birth_date"] ?? ""
    );
  }
}
