import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('ToDo'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: SizedBox(
          height: Get.height,
          child: controller.taskCount == 0
              ? const Center(
                  child: Text("no tasks"),
                )
              : ListView.builder(
                  itemCount: controller.taskCount,
                  itemBuilder: (BuildContext context, int index) {
                    final task = controller.tasks[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tasktile(
                        title: task.title,
                        desc: task.desc,
                        date: task.date,
                        time: task.time,
                        longpressCall: () {
                          controller.deleteTask(task);
                        },
                        checkedTrue: (checkboxState) {
                          controller.updateTask(task);
                        },
                        ischecked: task.isComplete,
                      ),
                    );
                  },
                ),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADDTODO);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Tasktile extends StatelessWidget {
  const Tasktile({
    Key? key,
    this.title,
    this.desc,
    this.ischecked,
    this.longpressCall,
    this.checkedTrue,
    this.date,
    this.time,
  }) : super(key: key);
  final String? title;
  final String? desc;
  final String? date;
  final String? time;
  final bool? ischecked;
  final VoidCallback? longpressCall;
  final Function(bool?)? checkedTrue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longpressCall,
      title: Text(
        title ?? '',
        style: TextStyle(
            decoration: ischecked == true ? TextDecoration.lineThrough : null),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(desc ?? ''), Text(date ?? ''), Text(time ?? '')],
      ),
      trailing: Checkbox(
        value: ischecked,
        onChanged: checkedTrue,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.black26,
          )),
    );
  }
}
