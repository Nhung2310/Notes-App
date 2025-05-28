import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app_routes_name.dart';
import 'package:note_app/controller/searching_controller.dart';
import 'package:note_app/widget/app_color.dart';

class SearchingNoteEmptyScreen extends GetView<SearchingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
        color: AppColor.black,
        child: Column(
          children: [
            TextField(
              controller: controller.textSearch,
              decoration: InputDecoration(
                hintText: 'Search your note...',
                hintStyle: TextStyle(color: AppColor.grey, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: AppColor.white, size: 20),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                filled: true,
                fillColor: AppColor.grey.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColor.grey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColor.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColor.white, width: 1),
                ),
              ),
              style: TextStyle(fontSize: 14, color: AppColor.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                final notes = controller.result;

                if (notes.isEmpty) {
                  return Center(
                    child: Text(
                      'Create your first note!'.tr,
                      style: TextStyle(color: AppColor.white, fontSize: 18),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    Color color;
                    if (note.backgroundColor != 0) {
                      color = Color(note.backgroundColor);
                      if (color == Colors.black) {
                        color = controller.getColorByIndex(index);
                      }
                    } else {
                      color = controller.getColorByIndex(index);
                    }

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoutesName.sampleNote,
                          arguments: note.toMap(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: color.withOpacity(0.6)),
                        ),
                        child: Text(
                          note.title,
                          style: TextStyle(color: AppColor.white, fontSize: 18),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
