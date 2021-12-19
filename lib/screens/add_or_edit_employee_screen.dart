import 'package:flutter/material.dart';
import 'package:flutter_hive_crud_app/employee.dart';
import 'package:flutter_hive_crud_app/screens/employee_list_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddOrEditEmployeeScreen extends StatefulWidget {
  final bool isEdit;
  final int? position; //pode ser nulo
  final Employee? employeeModel; //pode ser nulo

  // ignore: use_key_in_widget_constructors
  const AddOrEditEmployeeScreen(this.isEdit,
      [this.position, this.employeeModel]);

  @override
  State<StatefulWidget> createState() {
    return AddOrEditEmployeeState();
  }
}

class AddOrEditEmployeeState extends State<AddOrEditEmployeeScreen> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  TextEditingController controllerSalary = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      controllerName.text = widget.employeeModel!.empName.toString();
      controllerSalary.text = widget.employeeModel!.empSalary.toString();
      controllerAge.text = widget.employeeModel!.empAge.toString();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: !widget.isEdit
                ? const Text('Novo Empregado')
                : const Text('Editar Empregado')),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Nome do Empregado: ",
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(controller: controllerName),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Salário do Empregado: ",
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: controllerSalary,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text("Idade do Empregado: ",
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: controllerAge,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    shadowColor: Colors.orangeAccent,
                    elevation: 5,
                  ),
                  child: const Text("Guardar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    var getEmpName = controllerName.text;
                    var getEmpSalary = controllerSalary.text;
                    var getEmpAge = controllerAge.text;

                    if (widget.isEdit) {
                      Employee updateEmployee = Employee(
                          empName: getEmpName,
                          empSalary: getEmpSalary,
                          empAge: getEmpAge);

                      var box = await Hive.openBox<Employee>('employee');
                      box.putAt(widget.position!.toInt(), updateEmployee);
                    } else {
                      Employee addEmployee = Employee(
                          empName: getEmpName,
                          empSalary: getEmpSalary,
                          empAge: getEmpAge);
                      var box = await Hive.openBox<Employee>('employee');
                      box.add(addEmployee);
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EmployeesListScreen()),
                        (route) => false);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
