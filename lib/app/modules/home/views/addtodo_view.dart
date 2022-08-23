import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task/app/modules/home/controllers/home_controller.dart';

class AddtodoView extends GetView<HomeController> {
  const AddtodoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? newTask;
    String? desc;
    String? date;
    String? time;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AddtodoView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextField(
                onChanged: (newText) {
                  newTask = newText;
                },
                decoration: InputDecoration(hintText: 'title'),
                textAlign: TextAlign.center,
              ),
              TextField(
                onChanged: (newDesc) {
                  desc = newDesc;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'desc',
                ),
              ),
              DateTimePicker(
                initialValue: '',
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                dateLabelText: 'Date',
                onChanged: (val) => (date = val),
              ),
              DateTimePicker(
                type: DateTimePickerType.time,
                initialValue: '',
                initialTime: TimeOfDay.now(),
                timeLabelText: 'time',
                onChanged: (val) => (time = val),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await controller.addTask(
                      newTask: newTask,
                      desc: desc,
                      date: date,
                      time: time,
                    );

                    NotificationService().showNotification(
                      1,
                      newTask!,
                      desc!,
                    );
                    Get.back();
                  },
                  child: Text("Add Task"))
            ],
          ),
        ),
      ),
    );
  }
}
