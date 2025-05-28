import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';

class SampleNoteController extends GetxController {
  final title = ''.obs;
  final content = ''.obs;

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  late Note note;
  @override
  void onInit() {
    super.onInit();

    final data = Get.arguments as Map<String, dynamic>?;
    if (data != null) {
      try {
        note = Note.fromMap(data);
        titleController.text = note!.title;
        contentController.text = note!.content;
      } catch (e) {
        print("Lỗi dữ liệu ghi chú: $e");
      }
    }

    titleController.addListener(() {
      title.value = titleController.text;
    });
    contentController.addListener(() {
      content.value = contentController.text;
    });
  }

  void initNote(Note note) {
    title.value = note.title;
    content.value = note.content;
    titleController.text = note.title;
    contentController.text = note.content;
  }

  Color getColorByIndex(int index) {
    final colors = [Colors.blue, Colors.green, Colors.red];
    return colors[index % colors.length];
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
