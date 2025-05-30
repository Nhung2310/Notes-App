import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ColorPickerButton extends StatelessWidget {
  final String label;
  final Color initialColor;
  final Function(Color) onColorChanged;

  const ColorPickerButton({
    super.key,
    required this.label,
    required this.initialColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.color_lens, color: initialColor),
      onPressed: () {
        Color selectedColor = initialColor;
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Text('Choose color $label'.tr),
                content: ColorPicker(
                  pickerColor: initialColor,
                  onColorChanged: (color) => selectedColor = color,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      onColorChanged(selectedColor);
                      Navigator.pop(context);
                    },
                    child: Text('Chọn'.tr),
                  ),
                ],
              ),
        );
      },
    );
  }
}
