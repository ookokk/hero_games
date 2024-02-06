import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback? onIconButtonPressed;
  final Icon icon;
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.onIconButtonPressed,
    required this.icon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 52,
            child: TextFormField(
              keyboardType: keyboardType,
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: onIconButtonPressed,
                    icon: icon,
                  ),
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  filled: true,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
