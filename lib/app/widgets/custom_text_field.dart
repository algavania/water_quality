import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../common/color_values.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
        this.controller,
        this.hintText,
        this.isPassword = false,
        this.enabled = true,
        this.isDense = false,
        this.textInputType,
        this.validator,
        this.label,
        this.suffixIcon,
        this.prefixIcon, this.maxLines, this.minLines, this.backgroundColor})
      : super(key: key);
  final TextEditingController? controller;
  final String? hintText, label;
  final bool isPassword, enabled, isDense;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon, suffixIcon;
  final int? maxLines, minLines;
  final Color? backgroundColor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.transparent));
    Widget textField = TextFormField(
      obscureText: widget.isPassword && !_isShowPassword,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 11.sp),
        fillColor: widget.backgroundColor ?? ColorValues.lightGrey,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: widget.isDense ? 10 : 20),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 30,
        ),
        suffixIcon: widget.suffixIcon ?? (widget.isPassword
            ? GestureDetector(
          onTap: () {
            setState(() {
              _isShowPassword = !_isShowPassword;
            });
          },
          child: Icon(
            _isShowPassword ? Icons.visibility_off : Icons.visibility, color: ColorValues.iconGrey,
          ),
        )
            : null),
      ),
    );

    if (widget.label != null) {
      textField = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label!, style: TextStyle(fontSize: 11.sp),),
          SizedBox(height: 1.h),
          textField
        ],
      );
    }
    return widget.enabled ? textField : AbsorbPointer(child: textField);
  }
}
