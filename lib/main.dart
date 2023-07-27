import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'utils/db/blood.dart';
import 'utils/db_firebase.dart';
import 'views/log_in/login.dart';
import 'views/page_view/view.dart';

Future<void> main() async {
  final db = DbHelper();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BloodInDbAdapter());
  Hive.registerAdapter(StationsAdapter());
  Hive.registerAdapter(BloodOutDbAdapter());

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await db.getBloodRecords();
  // await db.getStations();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood bank',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LogInView(),
    );
  }
}
