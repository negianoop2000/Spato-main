import 'package:flutter/material.dart';

import '../flutter_slidable.dart';

const int _kFlex = 1;
const Color _kBackgroundColor = Colors.white;
const bool _kAutoClose = true;

typedef SlidableActionCallback = void Function(BuildContext context);

class CustomSlidableAction extends StatelessWidget {
  const CustomSlidableAction({
    Key? key,
    this.flex = _kFlex,
    this.backgroundColor = _kBackgroundColor,
    this.foregroundColor,
    this.autoClose = _kAutoClose,
    this.borderRadius = BorderRadius.zero,
    this.padding,
    required this.onPressed,
    required this.child,
  })  : assert(flex > 0),
        super(key: key);

  final int flex;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool autoClose;
  final SlidableActionCallback? onPressed;
  final BorderRadius borderRadius;
  final EdgeInsets? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final effectiveForegroundColor = foregroundColor ??
        (ThemeData.estimateBrightnessForColor(backgroundColor) ==
            Brightness.light
            ? Colors.black
            : Colors.white);

    return Expanded(
      flex: flex,
      child: SizedBox.expand(
        child: OutlinedButton(
          onPressed: () => _handleTap(context),
          style: OutlinedButton.styleFrom(
            padding: padding,
            backgroundColor: backgroundColor,
            disabledForegroundColor:
            effectiveForegroundColor.withOpacity(0.38),
            foregroundColor: effectiveForegroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            side: BorderSide.none,
          ),
          child: child,
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    onPressed?.call(context);
    if (autoClose) {
      Slidable.of(context)?.close();
    }
  }
}

class SlidableAction extends StatelessWidget {
  const SlidableAction({
    Key? key,
    this.flex = _kFlex,
    this.backgroundColor = _kBackgroundColor,
    this.foregroundColor,
    this.autoClose = _kAutoClose,
    required this.onPressed,
    this.image, // Added ImageProvider support
    this.spacing = 4,
    this.label,
    this.borderRadius = BorderRadius.zero,
    this.padding,
  })  : assert(flex > 0),
        assert(image != null || label != null),
        super(key: key);

  final int flex;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool autoClose;
  final SlidableActionCallback? onPressed;
  final ImageProvider? image; // Updated to ImageProvider
  final double spacing;
  final String? label;
  final BorderRadius borderRadius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (image != null) { // Check if image is provided
      children.add(
        Image(image: image!),
      );
    } else if (label != null) {
      children.add(
        Text(
          label!,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    final child = children.length == 1
        ? children.first
        : Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...children.map(
              (child) => Flexible(
            child: child,
          ),
        )
      ],
    );

    return CustomSlidableAction(
      borderRadius: borderRadius,
      padding: padding,
      onPressed: onPressed,
      autoClose: autoClose,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      flex: flex,
      child: child,
    );
  }
}
