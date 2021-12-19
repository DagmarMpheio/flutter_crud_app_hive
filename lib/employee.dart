import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee {
  @HiveField(0)
  late String empName;

  @HiveField(1)
  late String empSalary;

  @HiveField(2)
  late String empAge;

  Employee({required this.empName, required this.empSalary, required this.empAge});
}
