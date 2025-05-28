import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/model/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchingController extends GetxController {
  RxList<Note> notes = <Note>[].obs;
  TextEditingController textSearch = TextEditingController();
  var result = <Note>[].obs;

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedNotes = prefs.getStringList('saved_notes') ?? [];
    notes.value =
        savedNotes.map((noteStr) {
          final Map<String, dynamic> map = jsonDecode(noteStr);
          return Note.fromMap(map);
        }).toList();
    print(
      "Loaded notes in SearchingController: ${notes.map((note) => note.toMap())}",
    );
  }

  @override
  void onInit() {
    super.onInit();
    loadNotes();
    textSearch.addListener(() {
      search(textSearch.text);
    });
  }

  void search(String query) {
    print("Searching for: $query");
    if (query.isEmpty) {
      result.clear();
    } else {
      result.value =
          notes
              .where(
                (note) =>
                    note.title.toLowerCase().contains(query.toLowerCase()) ||
                    note.content.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
      print("Search results: ${result.map((note) => note.toMap())}");
    }
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

  @override
  void onClose() {
    textSearch.dispose();
    super.onClose();
  }
}
