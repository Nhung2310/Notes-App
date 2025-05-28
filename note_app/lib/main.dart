import 'package:flutter/material.dart';
import 'package:note_app/app_routes_name.dart';
import 'package:note_app/binding/editor_binding.dart';
import 'package:note_app/binding/home_binding.dart';
import 'package:note_app/binding/sample_note_binding.dart';
import 'package:note_app/messages.dart';
import 'package:note_app/ui/editor_screen.dart';
import 'package:note_app/ui/home_screen.dart';
import 'package:get/get.dart';
import 'package:note_app/ui/sample_note_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: Locale('vi', 'US'),
      fallbackLocale: Locale('vi', 'VN'),

      title: 'Note App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutesName.home,
      initialBinding: HomeBinding(),
      getPages: [
        GetPage(
          name: AppRoutesName.home,
          page: () => HomeScreen(),
          binding: HomeBinding(),
          // bindings: [HomeBinding(), EditorBinding(), SampleNoteBinding()],
        ),
        GetPage(
          name: AppRoutesName.editor,
          page: () => EditorScreen(),
          binding: EditorBinding(),
          //arguments: Get.arguments,
        ),
        GetPage(
          name: AppRoutesName.sampleNote,
          page: () => SampleNoteScreen(),
          binding: SampleNoteBinding(),
        ),
      ],
      //home: const HomeScreen(),
    );
  }
}
