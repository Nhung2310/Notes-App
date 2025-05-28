import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';

class SampleNoteController extends GetxController {
  // Reactive variables
  final title = ''.obs; // RxString for title
  final content = ''.obs; // RxString for content

  // TextEditingControllers for input fields
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Sync TextEditingController with RxString
    titleController.addListener(() {
      title.value = titleController.text;
    });
    contentController.addListener(() {
      content.value = contentController.text;
    });
  }

  // Initialize controller with note data
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
