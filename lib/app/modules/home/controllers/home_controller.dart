import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HomeController extends GetxController {
  final RxList<Task> todos = <Task>[].obs;
  int get taskCount {
    return todos.length;
  }

  List<Task> get tasks {
    return todos;
  }

  addTask({newTask, desc, dateTime, date, time}) {
    final task = Task(title: newTask, desc: desc, date: date, time: time);
    todos.add(task);
  }

  updateTask(Task task) {
    task.toggleDone();
  }

  deleteTask(Task task) {
    todos.remove(task);
  }
}

class Task {
  final String? title;
  final String? desc;
  final String? date;
  final String? time;
  bool? isComplete;

  Task({
    this.date,
    this.time,
    this.desc,
    this.isComplete = false,
    this.title,
  });
  toggleDone() {
    isComplete = !isComplete!;
  }
}

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final LinuxInitializationSettings initializationSettingslinux =
      const LinuxInitializationSettings(defaultActionName: 'todo');
  Future<void> initNotification() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(linux: initializationSettingslinux);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(int id, String title, String body) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(
        Duration(seconds: 1),
      ), //schedule the notification to show after 2 seconds.
      const NotificationDetails(
          linux: LinuxNotificationDetails(
              category: LinuxNotificationCategory('todo'))),

      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}
