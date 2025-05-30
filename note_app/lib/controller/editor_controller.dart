import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app_routes_name.dart';
import 'package:note_app/controller/home_controller.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/widget/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class EditorController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final title = ''.obs;
  final content = ''.obs;
  String? _noteId;
  final backgroundColor = 0xFF000000.obs;
  final textColor = 0xFFFFFFFF.obs;
  final isEditing = false.obs;

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

    loadData();
  }

  void refresh() {
    titleController.clear();
    contentController.clear();
    title.value = '';
    content.value = '';
    _noteId = null;
  }

  Future<void> saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final title = titleController.text.trim();
      final content = contentController.text.trim();

      if (title.isEmpty || content.isEmpty) {
        Get.back();
        Get.snackbar(
          'Error',
          'Title and content cannot be empty',
          backgroundColor: AppColor.white,
          colorText: AppColor.black,
        );

        return;
      }

      final id = _noteId ?? Uuid().v4();

      final note = Note(
        id: id,
        title: title,
        content: content,
        backgroundColor: backgroundColor.value,
        textColor: textColor.value,
      );

      final savedNotes = prefs.getStringList('saved_notes') ?? [];

      final List<Map<String, dynamic>> notesList =
          savedNotes
              .map((noteJson) => jsonDecode(noteJson) as Map<String, dynamic>)
              .toList();

      final existingNoteIndex = notesList.indexWhere(
        (noteMap) => noteMap['id'] == id,
      );
      if (existingNoteIndex != -1) {
        notesList[existingNoteIndex] = note.toMap();
      } else {
        notesList.add(note.toMap());
      }

      await prefs.setStringList(
        'saved_notes',
        notesList.map((noteMap) => jsonEncode(noteMap)).toList(),
      );

      refresh();
      Get.find<HomeController>().loadNotes();
      Get.toNamed(AppRoutesName.home);

      Get.snackbar(
        'Success',
        'Note saved successfully',
        backgroundColor: AppColor.white,
        colorText: AppColor.black,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save note: $e',
        backgroundColor: AppColor.white,
        colorText: AppColor.black,
      );
    }
  }

  void loadData() {
    try {
      print("data:  ${Get.arguments}");

      final data = Get.arguments as Map<String, dynamic>?;
      if (data != null) {
        final note = Note.fromMap(data);
        titleController.text = note.title;
        contentController.text = note.content;
        title.value = note.title;
        content.value = note.content;
        _noteId = note.id;
        backgroundColor.value = note.backgroundColor;
        textColor.value = note.textColor;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load note data: $e',
        backgroundColor: AppColor.white,
        colorText: AppColor.black,
      );
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }

  Future dialog(String text) {
    return Get.dialog(
      barrierColor: Colors.grey.withOpacity(0.7),
      Dialog(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.black,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.question_mark_rounded, color: AppColor.white),
              Text(text, style: TextStyle(color: AppColor.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Discard'.tr),
                    style: TextButton.styleFrom(foregroundColor: AppColor.red),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Save'.tr),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColor.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
