import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:note_app/model/note.dart';
import 'package:note_app/widget/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxList<Note> notes = <Note>[].obs;

  Future<void> loadNotes() async {
    // if (!Get.isRegistered<SearchingController>()) {
    //   Get.put(SearchingController());
    // }

    final prefs = await SharedPreferences.getInstance();
    final List<String> savedNotes = prefs.getStringList('saved_notes') ?? [];

    notes.value =
        savedNotes.map((noteStr) {
          final Map<String, dynamic> map = jsonDecode(noteStr);
          return Note.fromMap(map);
        }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  final List<Color> noteColors = [
    Colors.red.shade500,
    Colors.green.shade200,
    Colors.blue.shade200,

    Colors.orange.shade200,
    Colors.purple.shade200,
    Colors.teal.shade200,
    Colors.pink.shade200,
    Colors.amber.shade200,
    Colors.cyan.shade200,
    Colors.indigo.shade200,
    Colors.lime.shade200,
  ];

  Color getColorByIndex(int index) {
    return noteColors[index % noteColors.length];
  }

  Future<void> deleteData(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedNotes = prefs.getStringList('saved_notes') ?? [];

      final List<Map<String, dynamic>> notesList =
          savedNotes
              .map((noteJson) => jsonDecode(noteJson) as Map<String, dynamic>)
              .toList();

      notesList.removeWhere((noteMap) => noteMap['id'] == id);

      await prefs.setStringList(
        'saved_notes',
        notesList.map((noteMap) => jsonEncode(noteMap)).toList(),
      );

      Get.find<HomeController>().loadNotes();

      Get.snackbar(
        'Success',
        'Note deleted successfully',
        backgroundColor: AppColor.white,
        colorText: AppColor.black,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete note: $e',
        backgroundColor: AppColor.white,
        colorText: AppColor.black,
      );
    }
  }
}
