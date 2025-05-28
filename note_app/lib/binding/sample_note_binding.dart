import 'package:get/get.dart';
import 'package:note_app/controller/sample_note_controller.dart';

class SampleNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SampleNoteController());
  }
}
