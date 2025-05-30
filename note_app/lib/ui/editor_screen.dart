import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/editor_controller.dart';
import 'package:note_app/widget/app_color.dart';

class EditorScreen extends GetView<EditorController> {
  // final textController = Get.put(EditorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),

          color: Color(controller.backgroundColor.value),
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
                            showDialog(
                              context: context,
                              builder:
                                  (ctx) => AlertDialog(
                                    title: Text("Choose background color".tr),
                                    content: SingleChildScrollView(
                                      child: BlockPicker(
                                        pickerColor: Color(
                                          controller.backgroundColor.value,
                                        ),
                                        onColorChanged: (Color color) {
                                          controller.backgroundColor.value =
                                              color.value;
                                        },
                                      ),
                                    ),
                                  ),
                            );
                          },
                          icon: Icon(Icons.color_lens, color: AppColor.white),
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
                                        style: TextStyle(color: AppColor.white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.dialog(
                                                'Are your sure you want discard your changes ?'
                                                    .tr,
                                              );
                                            },
                                            child: Text('Discard'.tr),
                                            style: TextButton.styleFrom(
                                              foregroundColor: AppColor.red,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed:
                                                () => controller.saveData(),
                                            child: Text('Save'.tr),
                                            style: TextButton.styleFrom(
                                              foregroundColor: AppColor.green,
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
                  ),
                ],
              ),

              TextField(
                maxLines: 4,

                controller: controller.titleController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Title'.tr,

                  hintStyle: TextStyle(color: AppColor.white, fontSize: 25),
                  filled: true,
                  fillColor: Color(controller.backgroundColor.value),

                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                style: TextStyle(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 25,
                ),
              ),

              TextField(
                maxLines: null,
                controller: controller.contentController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Type something...'.tr,
                  hintStyle: TextStyle(color: AppColor.white, fontSize: 20),
                  filled: true,
                  fillColor: Color(controller.backgroundColor.value),

                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                style: TextStyle(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
