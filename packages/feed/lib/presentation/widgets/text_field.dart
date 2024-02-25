import 'package:core/styles/colors.dart';
import 'package:flutter/material.dart';

Widget textFieldWidget(
  TextEditingController controller,
  String text, [
  TextInputType? keyboardType,
  bool? readOnly,
  Future<void> Function()? onTap,
]) {
  return TextField(
    readOnly: readOnly ?? false,
    keyboardType: keyboardType,
    onTap: onTap,
    controller: controller,
    decoration: InputDecoration(
      hintText: text,
      hintStyle: const TextStyle(
        color: Color(0xFFAAAAAA),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: kErrorColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: kErrorColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFFD1D1D6),
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
    ),
  );
}
