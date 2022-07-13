class requirement {
  final String id;
  final String name;
  final String description;
  bool check = false;
  requirement({this.id, this.name, this.description});

  factory requirement.fromJson(Map<String, dynamic> json) {
    return requirement(
        id: json["ID"] as String,
        name: json["Name"] as String,
        description: json["Description"] as String);
  }
  Map<String, dynamic> toJasonAdd() {
    return {"Name": name, "Description": description};
  }

  factory requirement.fromJson2(Map<String, dynamic> json) {
    return requirement(
        name: json["RName"] as String,
        description: json["Description"] as String);
  }
}
