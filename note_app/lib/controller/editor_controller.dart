import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app_routes_name.dart';
import 'package:note_app/controller/home_controller.dart';
import 'package:note_app/model/note.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class EditorController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final title = ''.obs; // Reactive variable for title
  final content = ''.obs; // Reactive variable for content
  String? _noteId; // Store the ID of the note being edited (null for new notes)

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
    // Load note data if passed as arguments
    loadData();
  }

  Future<void> refresh() async {
    titleController.clear();
    contentController.clear();
    title.value = '';
    content.value = '';
    _noteId = null; // Reset note ID for new note
  }

  Future<void> saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final title = titleController.text.trim();
      final content = contentController.text.trim();

      if (title.isEmpty || content.isEmpty) {
        Get.snackbar('Error', 'Title and content cannot be empty');
        return;
      }

      final id = _noteId ?? Uuid().v4();

      final note = Note(id: id, title: title, content: content);

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

      await refresh();

      Get.find<HomeController>().loadNotes();

      Get.toNamed(AppRoutesName.home);

      // Notify user
      Get.snackbar('Success', 'Note saved successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save note: $e');
    }
  }

  Future<void> loadData() async {
    try {
      final data = Get.arguments as Map<String, dynamic>?;
      if (data != null) {
        final note = Note.fromMap(data);
        titleController.text = note.title;
        contentController.text = note.content;
        title.value = note.title;
        content.value = note.content;
        _noteId = note.id;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load note data: $e');
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
