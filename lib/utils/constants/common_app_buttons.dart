import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spato_mobile_app/utils/constants/app_text_styles.dart';
import 'package:spato_mobile_app/utils/constants/colors.dart';



class CommonAppButton extends StatelessWidget {
  const CommonAppButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.btnTextStyle,
    this.height,
    this.width,
    this.color,
    this.decoration,
    this.prefixWidget,
    this.spaceBtWidgetandText = 0.0,
    this.margin,
    this.btnIcon,
    this.borderColor,
    this.borderRadius,
    this.hasShadow,
    this.btnIconColor,
    this.isLoading = false,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback? onPressed;
  final TextStyle? btnTextStyle;
  final double? height;
  final double? width;
  final Color? color;
  final Color? borderColor;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;
  final Widget? prefixWidget;
  final double? spaceBtWidgetandText;
  final bool? hasShadow;
  final double? borderRadius;
  final IconData? btnIcon;
  final Color? btnIconColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
 //   final themeColors = Provider.of<ThemeColors>(context);

    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: height ?? 50,
        width: width ?? 120,
        margin: margin ?? EdgeInsets.zero,
        decoration: decoration ??
            BoxDecoration(
              border: Border.all(
                color: borderColor ?? Colors.transparent,
              ),
              color: color ?? (TColors.black),
              borderRadius: BorderRadius.circular(borderRadius ?? 16),
              boxShadow: hasShadow == true
                  ? [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ]
                  : [],
            ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              if (!isLoading && prefixWidget != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: prefixWidget!,
                ),
              if (!isLoading)
                SizedBox(width: spaceBtWidgetandText),
              if (!isLoading)
                Text(
                  buttonText,
                  style: btnTextStyle ?? AppTextStyles.black20,
                ),
              if (!isLoading && btnIcon != null)
                Icon(btnIcon, color: btnIconColor ?? Colors.transparent),
            ],
          ),
        ),
      ),
    );
  }
}
