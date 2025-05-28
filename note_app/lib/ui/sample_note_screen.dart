import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/sample_note_controller.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/widget/app_color.dart';

class SampleNoteScreen extends GetView<SampleNoteController> {
  @override
  Widget build(BuildContext context) {
    final data = Get.arguments as Map<String, dynamic>?;
    if (data == null) {
      return Scaffold(body: Center(child: Text("No note data")));
    }

    try {
      final note = Note.fromMap(data);
      controller.titleController.text = note.title;
      controller.contentController.text = note.content;

      return Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
          color: AppColor.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.grey,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios, color: AppColor.white),
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.grey,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, color: AppColor.white),
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                controller.titleController.text,
                style: TextStyle(color: AppColor.white, fontSize: 25),
              ),
              SizedBox(height: 50),
              Text(
                controller.contentController.text,
                style: TextStyle(color: AppColor.white, fontSize: 20),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      return Scaffold(body: Center(child: Text("Invalid note data")));
    }
  }
}
