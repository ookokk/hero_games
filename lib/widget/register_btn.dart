import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final Color? borderColor;

  const RegisterButton({
    Key? key,
    this.textStyle,
    this.borderColor,
    this.color,
    this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: borderColor ?? Theme.of(context).primaryColor),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(200, 55),
          ),
          maximumSize: MaterialStateProperty.all<Size>(
            const Size(200, 55),
          ),
          elevation: MaterialStateProperty.all<double>(2),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            color ?? Theme.of(context).primaryColor,
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
                  .labelMedium
                  ?.copyWith(color: Colors.white70),
        ),
      ),
    );
  }
}
