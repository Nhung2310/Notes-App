import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/model/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxList<Note> notes = <Note>[].obs;

  Future<void> loadNotes() async {
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

  // Lấy màu theo vị trí index (tuần hoàn)
  Color getColorByIndex(int index) {
    return noteColors[index % noteColors.length];
  }
}
