import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/home_controller.dart';
import 'package:note_app/widget/app_assets.dart';
import 'package:note_app/widget/app_color.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add, color: AppColor.white),
        shape: CircleBorder(),
        backgroundColor: AppColor.black,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
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
                          color: AppColor.gray,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(Icons.search, color: AppColor.white),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.gray,

                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.info_outline, color: AppColor.white),
                          onPressed: () {
                            Get.dialog(
                              Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Chọn ngôn ngữ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      ListTile(
                                        title: const Text("Tiếng Việt"),
                                        onTap: () {
                                          Get.updateLocale(
                                            const Locale('vi', 'VN'),
                                          );
                                          Get.back();
                                        },
                                      ),
                                      ListTile(
                                        title: const Text("English"),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.icHome, fit: BoxFit.cover),
                    Text(
                      'Create your first note !'.tr,
                      style: TextStyle(color: AppColor.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
