import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app_routes_name.dart';

import 'package:note_app/controller/home_controller.dart';

import 'package:note_app/widget/app_color.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutesName.editor);
        },
        child: const Icon(Icons.add, color: AppColor.white),
        shape: CircleBorder(),
        backgroundColor: AppColor.black,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
        color: AppColor.black,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notes'.tr,
                    style: TextStyle(color: AppColor.white, fontSize: 30),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.grey,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.toNamed(AppRoutesName.searching);
                          },
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(Icons.search, color: AppColor.white),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.grey,

                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.info_outline, color: AppColor.white),
                          onPressed: () {
                            Get.dialog(
                              Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColor.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Select language'.tr,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      ListTile(
                                        title: Text('VietNamese'.tr),
                                        onTap: () {
                                          Get.updateLocale(
                                            const Locale('vi', 'VN'),
                                          );
                                          Get.back();
                                        },
                                      ),
                                      ListTile(
                                        title: Text("English".tr),
                                        onTap: () {
                                          Get.updateLocale(
                                            const Locale('en', 'US'),
                                          );
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          iconSize: 24,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Expanded(
                child: Obx(() {
                  final notes = controller.notes;

                  if (notes.isEmpty) {
                    return Center(
                      child: Text(
                        'Create your first note !'.tr,
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

                      return Dismissible(
                        key: Key(note.id.toString()),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (_) async {
                          final confirm = await Get.dialog<bool>(
                            AlertDialog(
                              title: Text('Confirm deletion'.tr),
                              content: Text(
                                'Are you sure you want to delete this note?'.tr,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(result: false),
                                  child: Text('Cancel'.tr),
                                ),
                                TextButton(
                                  onPressed: () => Get.back(result: true),
                                  child: Text('Delete'.tr),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            await controller.deleteData(note.id);
                            return true;
                          }

                          return false;
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutesName.sampleNote,
                              arguments: note.toMap(),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              note.title,
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 18,
                              ),
                            ),
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
      ),
    );
  }
}
