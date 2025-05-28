import 'package:get/get.dart';
import 'package:note_app/controller/searching_controller.dart';

class SearchingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchingController());
  }
}
