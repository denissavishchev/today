import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/constants.dart';
import 'package:today/model/habit_storage_model.dart';
import 'package:today/model/to_do_model.dart';
import 'package:today/model/water_model.dart';
import 'package:today/pages/main_page.dart';
import 'package:today/providers/daily_provider.dart';
import 'package:today/providers/habit_provider.dart';
import 'package:today/providers/hive_provider.dart';
import 'package:today/providers/main_provider.dart';
import 'package:today/providers/water_provider.dart';
import 'package:today/providers/to_do_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'model/buttons_model.dart';
import 'model/daily_model.dart';
import 'model/habit_model.dart';
import 'model/percent_model.dart';
import 'model/water_daily_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoModelAdapter());
  Hive.registerAdapter(DailyModelAdapter());
  Hive.registerAdapter(PercentModelAdapter());
  Hive.registerAdapter(HabitModelAdapter());
  Hive.registerAdapter(HabitStorageModelAdapter());
  Hive.registerAdapter(WaterSettingsModelAdapter());
  Hive.registerAdapter(WaterDailyModelAdapter());
  Hive.registerAdapter(ButtonsModelAdapter());
  await Hive.openBox<ToDoModel>('to_do_page');
  await Hive.openBox<DailyModel>('daily');
  await Hive.openBox<PercentModel>('percent');
  await Hive.openBox<HabitModel>('habits');
  await Hive.openBox<HabitStorageModel>('storage');
  await Hive.openBox<WaterSettingsModel>('water_settings');
  await Hive.openBox<WaterDailyModel>('water_daily');
  await Hive.openBox<ButtonsModel>('buttons');
  await Hive.openBox('notifications');
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
        channelKey: 'scheduled',
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
    debug: false
  );
  runApp(ListenableProvider(create: (cobtext) => HiveProvider(),
    child: const MyApp()));
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
          return ScreenUtilInit(
            designSize: const Size(360, 780),
            builder: (_, child) => MaterialApp(
              theme: pickerTheme,
              debugShowCheckedModeBanner: false,
              home: const MainPage(),
            ),
          );
    },
    );
  }
}

