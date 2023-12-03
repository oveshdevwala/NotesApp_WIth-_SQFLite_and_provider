import 'package:flutter/material.dart';
import 'package:notes_app_with_database_and_provider/provider/databaseprovider.dart';
import 'package:notes_app_with_database_and_provider/screens/homenotes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => DatabaseProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          home: HomeScreen(),
        ));
  }
}
