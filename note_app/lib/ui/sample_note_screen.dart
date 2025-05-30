import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/sample_note_controller.dart';

import 'package:note_app/widget/app_color.dart';

class SampleNoteScreen extends GetView<SampleNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
        color:
            (controller.note.backgroundColor != 0)
                ? Color(controller.note.backgroundColor)
                : AppColor.black,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor.grey,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back_ios, color: AppColor.white),
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ),
                Obx(() {
                  return controller.isEditing.value
                      ? Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.grey,
                            ),
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (ctx) => AlertDialog(
                                        title: Text(
                                          "Choose background color".tr,
                                        ),
                                        content: SingleChildScrollView(
                                          child: BlockPicker(
                                            pickerColor: Color(
                                              controller.note.backgroundColor,
                                            ),
                                            onColorChanged: (Color color) {
                                              controller.note.backgroundColor =
                                                  color.value;
                                            },
                                          ),
                                        ),
                                      ),
                                );
                              },
                              icon: Icon(
                                Icons.color_lens,
                                color: AppColor.white,
                              ),
                              iconSize: 20,
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ),
                          SizedBox(width: 20),

                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.grey,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Get.dialog(
                                  barrierColor: Colors.grey.withOpacity(0.7),
                                  Dialog(
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColor.black,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.question_mark_rounded,
                                            color: AppColor.white,
                                          ),
                                          Text(
                                            'Save changes ?'.tr,
                                            style: TextStyle(
                                              color: AppColor.white,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  controller.isEditing.value =
                                                      false;
                                                  Get.back();
                                                },
                                                child: Text('Discard'.tr),
                                                style: TextButton.styleFrom(
                                                  foregroundColor: AppColor.red,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  controller.updateNote();
                                                  controller.isEditing.value =
                                                      false;
                                                },
                                                child: Text('Save'.tr),
                                                style: TextButton.styleFrom(
                                                  foregroundColor:
                                                      AppColor.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.save_outlined,
                                color: AppColor.white,
                              ),
                              iconSize: 20,
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ),
                        ],
                      )
                      : Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.grey,
                        ),
                        child: IconButton(
                          onPressed: () {
                            controller.isEditing.value = true;
                          },
                          icon: Icon(Icons.edit, color: AppColor.white),
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      );
                }),
              ],
            ),
            SizedBox(height: 20),
            Obx(
              () => TextField(
                controller: controller.titleController,
                enabled: controller.isEditing.value,
                style: TextStyle(
                  color: Color(controller.note.textColor),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title...'.tr,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            SizedBox(height: 50),

            Obx(
              () => TextField(
                controller: controller.contentController,
                enabled: controller.isEditing.value,
                style: TextStyle(
                  color: Color(controller.note.textColor),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title...'.tr,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
