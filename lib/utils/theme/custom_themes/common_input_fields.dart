import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';

// import '../constants/app_text_styles.dart';
// import '../constants/colors.dart';



class TextInputField extends StatelessWidget {
  const TextInputField(
      {Key? key,
      this.labelText,
      this.hintText,
      this.isObsecure = false,
      this.keyboardType = TextInputType.text,
      this.isPasswordVisible = false,
      this.onVisibilityToggle,
      this.isPassword = false,
      this.onTap,
      this.readOnly = false,
      this.controller,
      this.contentPadding,
      this.hintStyle,
      this.labelStyle,
      this.suffixIconWidget,
      this.textInputAction,
      this.onChange,
      this.validator,
      this.maxLength,
      this.backgroundColor,
      this.floatingLabelBehavior,
      this.focusNode,
      this.margin,
      this.cursorColor,
      this.textStyle,
      this.isCollapsed = false,
      this.suffixWidget,
      this.inputFormatters,
      this.suffixIconWidgetHeight,
      this.suffixIconWidgetWidth,
      this.floatingLabelStyle,
      this.onEditingComplete,
      this.onFieldSubmit,
      this.maxLines,
      this.minLines,
      this.textAlign,
      this.height,
      this.width,
      this.border,
      this.enabledBorder,
      this.focusedBorder,
      this.onChangedToggle,
      this.prefixWidget,
      this.prefixIcon,
      this.prefixIconConstraints,
      this.prefixIconPadding,
      this.borderColor,
      this.alignment,
        this.showCursor,
      this.enabled = true,
        this.borderRadius = 12.0,
      this.textAlignVertical})
      : super(key: key);
  final String? labelText;
  final String? hintText;
  final bool isObsecure;
  final bool isPasswordVisible;
  final bool isPassword;
  final Function(bool)? onVisibilityToggle;
  final Function(bool)? onChangedToggle;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final bool? readOnly;
  final bool enabled;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? suffixIconWidget;
  final TextInputAction? textInputAction;
  final Function(String)? onChange;
  final EdgeInsetsGeometry? margin;
  final String? Function(String?)? validator;
  final int? maxLength;
  final Color? backgroundColor;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final FocusNode? focusNode;
  final Color? cursorColor;
  final TextStyle? textStyle;
  final bool isCollapsed;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final Widget? prefixIcon;
  final EdgeInsets? prefixIconPadding;
  final List<TextInputFormatter>? inputFormatters;
  final double? suffixIconWidgetWidth;
  final double? suffixIconWidgetHeight;
  final TextStyle? floatingLabelStyle;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmit;
  final int? maxLines;
  final int? minLines;
  final TextAlign? textAlign;
  final double? height;
  final double? width;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final BoxConstraints? prefixIconConstraints;
  final Color? borderColor;
  final Alignment? alignment;
  final TextAlignVertical? textAlignVertical;
  final double borderRadius;
  final bool? showCursor;

  @override
  Widget build(BuildContext context) {
    Color colorsecondary = Theme.of(context).brightness == Brightness.light
        ? TColors.colorsecondaryLight
        : TColors.colorsecondaryDark;
    Color background = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey.withOpacity(0.1)
        : TColors.black;
    Color borderColor = Theme.of(context).brightness == Brightness.light
        ? TColors.colorlightgrey
        : TColors.darkerGrey;
    return TextFormField(
      showCursor: showCursor ?? true,
      controller: controller,
      readOnly: readOnly ?? false,
      inputFormatters: inputFormatters,
      obscureText: isObsecure,
      keyboardType: keyboardType,
      enabled: enabled,
      onChanged: onChange,
      textInputAction: textInputAction ?? TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: maxLength,
      validator: validator,
      cursorHeight: kIsWeb ? null : 25,
      focusNode: focusNode,
      style: textStyle ?? AppTextStyles.grey14,
      textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: background,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: borderColor
          )
        ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(

      color: borderColor
      )
    ),
        suffix: suffixWidget,
        prefix: prefixWidget,
        prefixIcon: prefixIcon != null
            ? (kIsWeb &&
            ((minLines != null && minLines! > 1) ||
                (maxLines != null && maxLines! > 1)))
            ? Padding(
          padding: contentPadding != null
              ? contentPadding!.add(
            EdgeInsets.only(
                left: 10.0, right: 10, bottom: 10),
          )
              : EdgeInsets.only(
            left: 10.0,
            right: 10,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            widthFactor: 1.0,
            heightFactor: 3.2,
            child: prefixIcon,
          ),
        )
            : Padding(
          padding: prefixIconPadding ??
              EdgeInsets.only(left: 20, right: 20),
          child: prefixIcon,
        )
            : null,
        prefixIconConstraints: prefixIconConstraints ??
            BoxConstraints(
              minHeight: 10,
              minWidth: 10,
            ),
        isCollapsed: isCollapsed,
        counterText: "",
        border: border ?? InputBorder.none,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              left: 12,
              bottom: kIsWeb
                  ? 13
                  : Platform.isIOS
                  ? 20
                  : 13,
            ),
        hintText: hintText ?? '',
        hintStyle: hintStyle ??
            TextStyle(
              color: TColors.colordarkgrey,
              fontWeight: FontWeight.w400,
              fontSize: kIsWeb ? 14 : 14,
            ),
        labelText: labelText?? '',
        labelStyle: labelStyle ?? AppTextStyles.heading1,
        floatingLabelStyle: floatingLabelStyle ??
            AppTextStyles.grey16.copyWith(
              fontSize: 15,),
        suffixIcon: isPassword
            ? Container(
          margin: EdgeInsets.only(right: kIsWeb ? 10 : 15),
          child: IconButton(
            onPressed: () {
              onVisibilityToggle!(!isPasswordVisible);
            },
            icon: Icon(
              isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey,
              key: const Key('password_visibility_icon'),
            ),
            padding: EdgeInsets.zero,
            iconSize: kIsWeb ? 24 : 24,
          ),
        )
            : GestureDetector(
          onTap: () {
            onChangedToggle!(true);
          },
          child: SizedBox(
            width: suffixIconWidgetWidth,
            height: suffixIconWidgetHeight,
            child: suffixIconWidget,
          ),
        ),
        suffixIconConstraints:
        BoxConstraints(minHeight: 15, minWidth: 15),
        floatingLabelBehavior:
        floatingLabelBehavior ?? FloatingLabelBehavior.always,
      ),
      cursorColor: colorsecondary,
      cursorWidth: kIsWeb ? 1 : 2,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmit,
    );
  }
}

//import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:spato/utils/constants/app_text_styles.dart';
// import 'package:spato/utils/constants/colors.dart';
//
// // import '../constants/app_text_styles.dart';
// // import '../constants/colors.dart';
//
//
//
// class TextInputField extends StatelessWidget {
//   const TextInputField(
//       {Key? key,
//       this.labelText,
//       this.hintText,
//       this.isObsecure = false,
//       this.keyboardType = TextInputType.text,
//       this.isPasswordVisible = false,
//       this.onVisibilityToggle,
//       this.isPassword = false,
//       this.onTap,
//       this.readOnly = false,
//       this.controller,
//       this.contentPadding,
//       this.hintStyle,
//       this.labelStyle,
//       this.suffixIconWidget,
//       this.textInputAction,
//       this.onChange,
//       this.validator,
//       this.maxLength,
//       this.backgroundColor,
//       this.floatingLabelBehavior,
//       this.focusNode,
//       this.margin,
//       this.cursorColor,
//       this.textStyle,
//       this.isCollapsed = false,
//       this.suffixWidget,
//       this.inputFormatters,
//       this.suffixIconWidgetHeight,
//       this.suffixIconWidgetWidth,
//       this.floatingLabelStyle,
//       this.onEditingComplete,
//       this.onFieldSubmit,
//       this.maxLines,
//       this.minLines,
//       this.textAlign,
//       this.height,
//       this.width,
//       this.border,
//       this.enabledBorder,
//       this.focusedBorder,
//       this.onChangedToggle,
//       this.prefixWidget,
//       this.prefixIcon,
//       this.prefixIconConstraints,
//       this.prefixIconPadding,
//       this.borderColor,
//       this.alignment,
//         this.showCursor,
//       this.enabled = true,
//         this.borderRadius = 12.0,
//       this.textAlignVertical})
//       : super(key: key);
//   final String? labelText;
//   final String? hintText;
//   final bool isObsecure;
//   final bool isPasswordVisible;
//   final bool isPassword;
//   final Function(bool)? onVisibilityToggle;
//   final Function(bool)? onChangedToggle;
//   final TextInputType keyboardType;
//   final VoidCallback? onTap;
//   final bool? readOnly;
//   final bool enabled;
//   final TextEditingController? controller;
//   final EdgeInsetsGeometry? contentPadding;
//   final TextStyle? hintStyle;
//   final TextStyle? labelStyle;
//   final Widget? suffixIconWidget;
//   final TextInputAction? textInputAction;
//   final Function(String)? onChange;
//   final EdgeInsetsGeometry? margin;
//   final String? Function(String?)? validator;
//   final int? maxLength;
//   final Color? backgroundColor;
//   final FloatingLabelBehavior? floatingLabelBehavior;
//   final FocusNode? focusNode;
//   final Color? cursorColor;
//   final TextStyle? textStyle;
//   final bool isCollapsed;
//   final Widget? suffixWidget;
//   final Widget? prefixWidget;
//   final Widget? prefixIcon;
//   final EdgeInsets? prefixIconPadding;
//   final List<TextInputFormatter>? inputFormatters;
//   final double? suffixIconWidgetWidth;
//   final double? suffixIconWidgetHeight;
//   final TextStyle? floatingLabelStyle;
//   final Function()? onEditingComplete;
//   final Function(String)? onFieldSubmit;
//   final int? maxLines;
//   final int? minLines;
//   final TextAlign? textAlign;
//   final double? height;
//   final double? width;
//   final InputBorder? border;
//   final InputBorder? enabledBorder;
//   final InputBorder? focusedBorder;
//   final BoxConstraints? prefixIconConstraints;
//   final Color? borderColor;
//   final Alignment? alignment;
//   final TextAlignVertical? textAlignVertical;
//   final double borderRadius;
//   final bool? showCursor;
//
//   @override
//   Widget build(BuildContext context) {
//     Color colorsecondary = Theme.of(context).brightness == Brightness.light
//         ? TColors.colorsecondaryLight
//         : TColors.colorsecondaryDark;
//     return Container(
//       height: height,
//       width: width,
//       alignment: alignment ??
//           ((maxLines ?? 0) > 1 ? Alignment.topLeft : Alignment.centerLeft),
//       decoration: BoxDecoration(
//         color: backgroundColor ?? Color(0x1Aafd2d7),
//         border: Border.all(color: borderColor ?? Color(0xffa0abbc)),
//         borderRadius: BorderRadius.all(
//           Radius.circular(borderRadius),
//         ),
//       ),
//       margin: margin ?? EdgeInsets.symmetric(vertical: 6),
//       child: TextFormField(
//         showCursor: showCursor ?? true,
//         controller: controller,
//         readOnly: readOnly ?? false,
//         inputFormatters: inputFormatters,
//         obscureText: isObsecure,
//         keyboardType: keyboardType,
//         enabled: enabled,
//         onChanged: onChange,
//         textInputAction: textInputAction ?? TextInputAction.next,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         maxLength: maxLength,
//         validator: validator,
//         cursorHeight: kIsWeb ? null : 25,
//         focusNode: focusNode,
//         style: textStyle ?? AppTextStyles.grey14,
//         textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
//         textAlign: textAlign ?? TextAlign.start,
//         maxLines: maxLines ?? 1,
//         minLines: minLines ?? 1,
//         decoration: InputDecoration(
//           enabledBorder: enabledBorder,
//           focusedBorder: focusedBorder,
//           suffix: suffixWidget,
//           prefix: prefixWidget,
//           prefixIcon: prefixIcon != null
//               ? (kIsWeb &&
//                       ((minLines != null && minLines! > 1) ||
//                           (maxLines != null && maxLines! > 1)))
//                   ? Padding(
//                       padding: contentPadding != null
//                           ? contentPadding!.add(
//                               EdgeInsets.only(
//                                   left: 10.0, right: 10, bottom: 10),
//                             )
//                           : EdgeInsets.only(
//                               left: 10.0,
//                               right: 10,
//                             ),
//                       child: Align(
//                         alignment: Alignment.topLeft,
//                         widthFactor: 1.0,
//                         heightFactor: 3.2,
//                         child: prefixIcon,
//                       ),
//                     )
//                   : Padding(
//                       padding: prefixIconPadding ??
//                           EdgeInsets.only(left: 20, right: 20),
//                       child: prefixIcon,
//                     )
//               : null,
//           prefixIconConstraints: prefixIconConstraints ??
//               BoxConstraints(
//                 minHeight: 10,
//                 minWidth: 10,
//               ),
//           isCollapsed: isCollapsed,
//           counterText: "",
//           border: border ?? InputBorder.none,
//           contentPadding: contentPadding ??
//               EdgeInsets.only(
//                 left: 12,
//                 bottom: kIsWeb
//                     ? 13
//                     : Platform.isIOS
//                         ? 20
//                         : 13,
//               ),
//           hintText: hintText ?? '',
//           hintStyle: hintStyle ??
//               TextStyle(
//                 color: TColors.colordarkgrey,
//                 fontWeight: FontWeight.w400,
//                 fontSize: kIsWeb ? 14 : 14,
//               ),
//           labelText: labelText?? '',
//           labelStyle: labelStyle ?? AppTextStyles.heading1,
//           floatingLabelStyle: floatingLabelStyle ??
//               AppTextStyles.grey16.copyWith(
//                   fontSize: 15,),
//           suffixIcon: isPassword
//               ? Container(
//                   margin: EdgeInsets.only(right: kIsWeb ? 10 : 15),
//                   child: IconButton(
//                     onPressed: () {
//                       onVisibilityToggle!(!isPasswordVisible);
//                     },
//                     icon: Icon(
//                       isPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: Colors.grey,
//                       key: const Key('password_visibility_icon'),
//                     ),
//                     padding: EdgeInsets.zero,
//                     iconSize: kIsWeb ? 24 : 24,
//                   ),
//                 )
//               : GestureDetector(
//                   onTap: () {
//                     onChangedToggle!(true);
//                   },
//                   child: SizedBox(
//                     width: suffixIconWidgetWidth,
//                     height: suffixIconWidgetHeight,
//                     child: suffixIconWidget,
//                   ),
//                 ),
//           suffixIconConstraints:
//               BoxConstraints(minHeight: 15, minWidth: 15),
//           floatingLabelBehavior:
//               floatingLabelBehavior ?? FloatingLabelBehavior.always,
//         ),
//         cursorColor: TColors.black,
//         cursorWidth: kIsWeb ? 1 : 2,
//         onTap: onTap,
//         onEditingComplete: onEditingComplete,
//         onFieldSubmitted: onFieldSubmit,
//       ),
//     );
//   }
// }
