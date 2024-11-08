import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/manager/ui/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hint, this.validator, this.obscureText,
  });

  final TextEditingController? controller;
  final String? hint;
  final bool? obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      cursorColor: UiColor.color5,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: UiColor.dividerColor , width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: UiColor.dividerColor , width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: UiColor.dividerColor , width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: UiColor.cancelledColor , width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: UiColor.color5 , width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: UiColor.cancelledColor , width: 0.7),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14.sp , color: UiColor.dividerColor),
          fillColor: UiColor.dividerColor.withOpacity(0.9),
      ),
    );
  }
}