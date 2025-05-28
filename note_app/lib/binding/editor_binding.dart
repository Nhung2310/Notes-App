import 'package:get/get.dart';
import 'package:note_app/controller/editor_controller.dart';

class EditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditorController());
  }
}
