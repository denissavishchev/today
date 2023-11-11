import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/constants.dart';
import 'package:today/model/habit_storage_model.dart';
import 'package:today/model/to_do_model.dart';
import 'package:today/model/water_model.dart';
import 'package:today/pages/main_page.dart';
import 'package:today/providers/daily_provider.dart';
import 'package:today/providers/habit_provider.dart';
import 'package:today/providers/main_provider.dart';
import 'package:today/providers/water_provider.dart';
import 'package:today/providers/to_do_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'model/daily_model.dart';
import 'model/habit_model.dart';
import 'model/percent_model.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoModelAdapter());
  Hive.registerAdapter(DailyModelAdapter());
  Hive.registerAdapter(PercentModelAdapter());
  Hive.registerAdapter(HabitModelAdapter());
  Hive.registerAdapter(HabitStorageModelAdapter());
  Hive.registerAdapter(WaterSettingsModelAdapter());
  await Hive.openBox<ToDoModel>('to_do_page');
  await Hive.openBox<DailyModel>('daily_page');
  await Hive.openBox<PercentModel>('percents');
  await Hive.openBox<HabitModel>('habits');
  await Hive.openBox<HabitStorageModel>('storage');
  await Hive.openBox<WaterSettingsModel>('water_settings');
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
        channelKey: 'scheduled_channel',
        channelGroupKey: 'basic_channel_group',
        channelName: 'Scheduled Notifications',
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: 'Notification channel for basic tests',)
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
    debug: true
  );

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
          ChangeNotifierProvider<DailyProvider>(create: (_) => DailyProvider()),
          ChangeNotifierProvider<HabitProvider>(create: (_) => HabitProvider()),
          ChangeNotifierProvider<WaterProvider>(create: (_) => WaterProvider()),
        ],
      builder: (context, child) {
        final initNotifications = Provider.of<MainProvider>(context, listen: false);
        initNotifications.initNotifications();
          return MaterialApp(
            theme: pickerTheme,
            debugShowCheckedModeBanner: false,
            home: const MainPage(),
          );
    },
    );
  }
}

