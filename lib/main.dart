import 'package:flutter/material.dart';
import 'package:alquran_project/baseurl/base_app.dart';
import 'package:alquran_project/view/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: Status.debug,
      home: Splashscreen(),
      color: Colors.blue,
    );
  }
}
