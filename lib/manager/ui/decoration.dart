import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/manager/ui/color.dart';

class UiDecoration {
  static InputDecoration txtInputDecoration(
      {required String hint,
        void Function()? onTap,
        Widget? suffixIcon,
        Widget? prefixIcon}) =>
      InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconConstraints:
        const BoxConstraints(maxHeight: 50, minWidth: 40),
        prefixIcon: prefixIcon,
        // suffixTxt != null
        //     ? InkWell(
        //         onTap: onTap,
        //         hoverColor: Colors.transparent,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //               child: SizedBox(
        //                 child: Text(
        //                   suffixTxt,
        //                   style: TextStyle(
        //                     color: UiColor.hintTxtColor,
        //                     fontSize: 14.sp,
        //                     fontWeight: FontWeight.w500,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //     : null,
        hintText: hint,
        hintStyle: TextStyle(color: UiColor.hintTxtColor, fontSize: 14.sp),
        fillColor: UiColor.primaryColor,
        filled: true,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            borderSide: BorderSide(width: 1, color: UiColor.greyColor)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            borderSide: BorderSide(width: 1, color: UiColor.greyColor)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            borderSide: BorderSide(width: 1, color: UiColor.greyColor)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            borderSide: BorderSide(width: 1, color: UiColor.onBoardingActive)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            borderSide: BorderSide(width: 1, color: UiColor.onBoardingActive)),
      );

  static InputDecoration txtInpDecoration(
          {required String hint,
          Widget? suffixWidget,
          Color filledColor = UiColor.filledInputTxtColor,
          double radius = 5,
          TextStyle hintStyle =
              const TextStyle(color: UiColor.hintTxtColor, fontSize: 18),
          void Function()? onTap}) =>
      InputDecoration(
          suffixIcon: suffixWidget != null
              ? GestureDetector(
                  onTap: onTap,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: suffixWidget,
                      ),
                    ],
                  ),
                )
              : null,
          hintText: hint,
          hintStyle: hintStyle,
          fillColor: UiColor.filledInputTxtColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              borderSide: const BorderSide(
                  width: 1, color: UiColor.filledInputTxtColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              borderSide: const BorderSide(
                  width: 1, color: UiColor.filledInputTxtColor)));

  static InputDecoration txtInputDecoration1({
    required String hint,
    Color? hintColor,
    double? hintSize = 12,
    Color? filledColor,
    Color? borderColor = UiColor.primaryColor,
    double? radius = 11,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) =>
      InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: hintColor, fontSize: hintSize),
          fillColor: filledColor,
          filled: filledColor != null ? true : null,
          contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 30 , vertical: 10),
          suffixIconConstraints: const BoxConstraints(maxHeight: 30 , minWidth: 30),
          prefixIconConstraints: const BoxConstraints(maxHeight: 30 , minWidth: 30),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 4)),
              borderSide: borderColor != null
                  ? BorderSide(width: 1, color: borderColor)
                  : const BorderSide()),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 4)),
              borderSide: borderColor != null
                  ? BorderSide(width: 1, color: borderColor)
                  : const BorderSide()) , border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 4)),
          borderSide: borderColor != null
              ? BorderSide(width: 1, color: borderColor)
              : const BorderSide()) , disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 4)),
          borderSide: borderColor != null
              ? BorderSide(width: 1, color: borderColor)
              : const BorderSide()));

  static InputDecoration txtInputDecoration2(
          {required String hint,
          void Function()? onTap,
          Widget? suffixIcon,
          Widget? prefixIcon}) =>
      InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 50, minWidth: 40),
        prefixIcon: prefixIcon,
        // suffixTxt != null
        //     ? InkWell(
        //         onTap: onTap,
        //         hoverColor: Colors.transparent,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //               child: SizedBox(
        //                 child: Text(
        //                   suffixTxt,
        //                   style: TextStyle(
        //                     color: UiColor.hintTxtColor,
        //                     fontSize: 14.sp,
        //                     fontWeight: FontWeight.w500,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //     : null,
        hintText: hint,
        hintStyle: const TextStyle(color: UiColor.hintTxtColor, fontSize: 14),
        fillColor: UiColor.primaryColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            borderSide: BorderSide(width: 1, color: UiColor.primaryColor)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            borderSide: BorderSide(width: 1, color: UiColor.primaryColor)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            borderSide: BorderSide(width: 1, color: UiColor.primaryColor)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            borderSide: BorderSide(width: 1, color: UiColor.cancelledColor)),
      );
}
