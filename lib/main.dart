import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/constants.dart';
import 'package:today/model/to_do_model.dart';
import 'package:today/pages/main_page.dart';
import 'package:today/providers/main_provider.dart';
import 'package:today/providers/to_do_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoModelAdapter());
  await Hive.openBox<ToDoModel>('to_do_page');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
          ChangeNotifierProvider<ToDoProvider>(create: (_) => ToDoProvider()),
          // ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
          // ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
          // ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
        ],
      builder: (context, child) {
          return MaterialApp(
            theme: pickerTheme,
            debugShowCheckedModeBanner: false,
            home: const MainPage(),
          );
    },
    );
  }
}

