import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive_crud_app/employee.dart';
import 'package:flutter_hive_crud_app/screens/add_or_edit_employee_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EmployeesListScreen extends StatefulWidget {
  const EmployeesListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EmployeesListState();
  }
}

class EmployeesListState extends State<EmployeesListScreen>
    with TickerProviderStateMixin {
  List<Employee> listEmployees = [];

  bool reverse = false, reverse1 = false;
  late Animation animation;
  late Animation animation1;
  late AnimationController animationController, animationController1;

//retornar os empregados
  void getEmployees() async {
    final box = await Hive.openBox<Employee>('employee');
    setState(() {
      listEmployees = box.values.toList();
    });
  }

//ao iniciar a tela, vai carregar todos os dados
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animationController1 =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 2).animate(animationController);
    animation1 = Tween<double>(begin: 0, end: 2).animate(animationController1);

    getEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Empregados'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                /*if (reverse == false) {
                  animationController.forward();
                } else {
                  animationController1.reverse();
                  reverse = !reverse;
                }*/
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AddOrEditEmployeeScreen(false)));
              },
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: listEmployees.length,
            itemBuilder: (context, position) {
              Employee getEmployee = listEmployees[position];
              var salary = getEmployee.empSalary;
              var age = getEmployee.empAge;
              return Card(
                elevation: 8,
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.all(15),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          getEmployee.empName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 45),
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.orangeAccent,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AddOrEditEmployeeScreen(
                                          true, position, getEmployee)));
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.redAccent,
                          onPressed: () {
                            final box = Hive.box<Employee>('employee');
                            box.deleteAt(position);
                            setState(() {
                              listEmployees.removeAt(position);
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Salário: $salary | Idade: $age",
                          style: const TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
