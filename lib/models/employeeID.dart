import 'package:new_app/models/employee.dart';

class EmployeeID {
  final String id;
  EmployeeID(this.id);
  factory EmployeeID.fromJson(Map<String, dynamic> json) {
    return EmployeeID(json["ID"] as String);
  }
}
