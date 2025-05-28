import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
                title: Text('Chọn màu $label'),
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
                    child: const Text('Chọn'),
                  ),
                ],
              ),
        );
      },
    );
  }
}
