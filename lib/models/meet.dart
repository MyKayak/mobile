class Meet {
  String id;
  String name;
  String location;
  String date;

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