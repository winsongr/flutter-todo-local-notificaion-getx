import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/app/modules/home/controllers/home_controller.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(
    GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
