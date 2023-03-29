import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:water_quality/app/common/color_values.dart';

class SharedCode {
  static double defaultPadding = 30;
  static EdgeInsets defaultPagePadding = EdgeInsets.symmetric(vertical: defaultPadding, horizontal: 25.0);

  static String? emptyValidator(value) {
    return value.toString().trim().isEmpty ? 'Tidak boleh kosong' : null;
  }

  static Widget buildBottomButton({void Function()? onPressed, required String buttonText, Color? color}) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color
        ),
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }

  static Widget buildPopUp(
      {required Widget child, required BuildContext context}) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }

  static void showSnackBar(BuildContext context, bool isError, String content,
      {Duration? duration}) {
    Color color = isError ? Colors.red : Colors.green;
    SnackBar snackBar = SnackBar(
      content: Text(content, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      duration: duration ?? const Duration(milliseconds: 4000),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget buildTextData(String title, String content, String suffix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 10.sp),
        ),
        RichText(
          text: TextSpan(text: '', style: GoogleFonts.inter(), children: [
            TextSpan(
                text: content,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: ColorValues.primaryBlue,
                    fontSize: 18.sp)),
            TextSpan(
              text: suffix,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal),
            )
          ]),
        ),
      ],
    );
  }
}