class Meet {
  final String id;
  final String name;
  final String location;
  final String date;

  Meet(this.id, this.name, this.location, this.date);

  factory Meet.fromMap(Map<String, dynamic>map){
    return Meet(
      map["id"],
      map["name"],
      map["location"],
      map["date"],
    );
  }
}