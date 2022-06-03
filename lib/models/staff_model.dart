import 'package:cloud_firestore/cloud_firestore.dart';

class Staff {
  late int id;
  late String name;
  late int age;
  late double score;
  Staff(
      {required this.id,
      required this.name,
      required this.age,
      required this.score});
  Staff.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    age = map["age"];
    score = map["score"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "age": age,
    };
  }
}
