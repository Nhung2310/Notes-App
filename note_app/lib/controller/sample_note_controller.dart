import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:note_app/app_routes_name.dart';
import 'package:note_app/controller/home_controller.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/widget/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SampleNoteController extends GetxController {
  final title = ''.obs;
  final content = ''.obs;
  final isEditing = false.obs;

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  Note note = Note(
    id: 'id',
    title: '',
    content: '',
    backgroundColor: 0xFF000000,

    textColor: 0xFFFFFFFF,
  );

  @override
  void onInit() {
    super.onInit();

    loadData();
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

  void loadData() {
    print("Get.arguments: ${Get.arguments}");
    final data = Get.arguments as Map<String, dynamic>?;
    if (data == null) {
      print("No arguments received");
      Get.snackbar(
        "Error".tr,
        "Unable to receive data note".tr,
        backgroundColor: AppColor.white,
        colorText: AppColor.black,
      );
      return;
    }
    try {
      note = Note.fromMap(data);
      print("Note initialized: ${note.toMap()}");
      titleController.text = note.title;
      contentController.text = note.content;
      title.value = note.title;
      content.value = note.content;
      print("titleController.text: ${titleController.text}");
      print("contentController.text: ${contentController.text}");
    } catch (e) {
      print("Lỗi dữ liệu ghi chú: $e");
      Get.snackbar("Error".tr, "Failed to load note data: $e".tr);
      note = Note(
        id: '',
        title: '',
        content: '',
        backgroundColor: 0xFF000000,
        textColor: 0xFFFFFFFF,
      );
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }

  Future<void> updateNote() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final updatedTitle = titleController.text.trim();
      final updatedContent = contentController.text.trim();

      if (note.id.isEmpty) {
        Get.snackbar('Error'.tr, 'Note ID not found'.tr);
        return;
      }

      if (updatedTitle.isEmpty || updatedContent.isEmpty) {
        Get.snackbar('Error'.tr, 'Title and content cannot be empty'.tr);
        return;
      }

      note.title = updatedTitle;
      note.content = updatedContent;

      final savedNotes = prefs.getStringList('saved_notes') ?? [];

      final notesList =
          savedNotes.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();

      final index = notesList.indexWhere((e) => e['id'] == note.id);

      if (index != -1) {
        notesList[index] = note.toMap();
      } else {
        Get.snackbar('Error'.tr, 'No notes found to update'.tr);
        return;
      }

      await prefs.setStringList(
        'saved_notes',
        notesList.map((e) => jsonEncode(e)).toList(),
      );

      Get.back();
      Get.find<HomeController>().loadNotes();
      Get.toNamed(AppRoutesName.home);
      Get.snackbar('Success'.tr, 'Note updated successfully');
    } catch (e) {
      Get.snackbar('Error'.tr, 'Unable to update notes: $e'.tr);
    }
  }
}
