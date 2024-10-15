import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/app.dart';
import 'core/bloc/bloc_observer.dart';
import 'core/database/cache/cache_helper.dart';
import 'core/database/sqflite_helper/sqflite_helper.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/service_locator.dart';
import 'core/services/work_manager_service.dart';
import 'feature/task/presentation/cubit/task_cubit.dart';
import 'feature/task/presentation/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await setup();
  await sl<CacheHelper>().init();

  await Future.wait([
    LocalNotificationService.init(),
    Permission.notification.request(),
    WorkManagerService().init(),
  ]);

  await sl<SqfliteHelper>().intiDB();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit()..getTasks(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit()..getTheme(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
