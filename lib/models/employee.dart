import 'package:new_app/models/requirement.dart';
import 'package:new_app/models/subtask.dart';

class Employee {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  bool check = false;
  String success;
  Employee(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.success});
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json["ID"] as String,
        name: json["Name"] as String,
        email: json["Email"] as String,
        password: json["Password"] as String,
        phoneNumber: json["Phone"] as String);
  }
  factory Employee.fromJson2(Map<String, dynamic> json) {
    return Employee(
        name: json["EName"] as String,
        email: json["Email"] as String,
        phoneNumber: json["Phone"] as String,
        success: json["Success"] as String);
  }

  Map<String, dynamic> toJasonAdd() {
    return {"Name": name, "Email": email, "Phone": phoneNumber};
  }
}
