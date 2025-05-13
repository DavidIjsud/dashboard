import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Widget? icon;
  final bool isLoading;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = color ?? Theme.of(context).primaryColor;
    final txtColor = textColor ?? Colors.white;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor,
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
          disabledBackgroundColor: bgColor.withOpacity(0.6),
        ),
        child:
            isLoading
                ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
                : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon!, const SizedBox(width: 8)],
                    Text(text, style: TextStyle(color: txtColor, fontWeight: FontWeight.w600, fontSize: 16)),
                  ],
                ),
      ),
    );
  }
}
