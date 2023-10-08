import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DexterTextField extends StatelessWidget {
  final String? labelText;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Widget? icon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final double? width;
  final void Function()? onTap;
  final TextStyle? style;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;
  final bool? expands;
  final Widget? prefixIcon;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final EdgeInsetsGeometry? padding;
  final String? labelTitle;
  final TextStyle? labelTitleTextStyle;
  final bool? isDense;
  final double? height;
  final Color? filledColor;
  final String? initialValue;
  final bool? readOnly;

  const DexterTextField({
    Key? key,
    this.labelTitle,
    this.height,
    this.isDense,
    this.labelTitleTextStyle,
    this.labelText,
    this.labelStyle,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onSaved,
    this.controller,
    this.onChanged,
    this.icon,
    this.validator,
    this.width,
    this.onTap,
    this.suffixIcon,
    this.style,
    this.obscureText,
    this.maxLines,
    this.minLines,
    this.expands,
    this.prefixIcon,
    this.padding,
    this.hintText,
    this.hintTextStyle, this.filledColor, this.initialValue, this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      style: style ??
          Theme.of(context).textTheme.bodyText2?.copyWith(
            fontSize: 14,
            color: black,
          ),
      textCapitalization: TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: onSaved,
      controller: controller,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      minLines: maxLines,
      expands: expands ?? true,
      cursorHeight: 17,
      onTap: onTap,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        icon: icon,
        labelText: labelText,
        hintText: hintText,
        hintStyle: hintTextStyle ??
            Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: const Color(0xff868484), fontSize: 14),
        labelStyle: labelStyle ??
            Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: const Color(0xff868484), fontSize: 14),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Color(0xff868484), width: 0.7)),
        fillColor: filledColor ?? Color(0xffEFEFF0),
        filled: true,
        isDense: isDense ?? true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      ),
      cursorColor: Colors.black,
      validator: validator,
    );
  }
}