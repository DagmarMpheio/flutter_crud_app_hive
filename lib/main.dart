import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hive_crud_app/employee.dart';
import 'package:flutter_hive_crud_app/screens/employee_list_screen.dart';
import 'package:hive/hive.dart';
// ignore: library_prefixes
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'employee.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(EmployeeAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive CRUD APP',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: const EmployeesListScreen(),
    );
  }
}
