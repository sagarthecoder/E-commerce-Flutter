import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isObscureText;
  final String? placeholder;
  final RxString controllerValue;
  final Function(String value) onChange;
  final String? Function(String?)? validator;
  CustomTextField(
      {required this.label,
      required this.controllerValue,
      required this.onChange,
      this.validator,
      this.placeholder = "",
      this.isObscureText = false,
      super.key}) {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      return TextField(
          onChanged: (value) {
            controllerValue.value = value;
            onChange(value);
          },
          obscureText: isObscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            labelText: label,
            hintText: placeholder ?? "",
            errorText: validator?.call(controllerValue.value),
            filled: true,
          ));
    });
  }
}
