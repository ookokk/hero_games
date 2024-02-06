import 'package:flutter/material.dart';

final class AuthButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final Color? borderColor;

  const AuthButton({
    Key? key,
    this.textStyle,
    this.borderColor,
    this.color,
    this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: borderColor ?? Colors.white70),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(MediaQuery.of(context).size.width * 0.9,
              MediaQuery.of(context).size.height * 0.03),
        ),
        maximumSize: MaterialStateProperty.all<Size>(
          Size(double.infinity - 100,
              MediaQuery.of(context).size.height * 0.065),
        ),
        elevation: MaterialStateProperty.all<double>(3),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).scaffoldBackgroundColor,
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: textStyle ??
            Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }
}
