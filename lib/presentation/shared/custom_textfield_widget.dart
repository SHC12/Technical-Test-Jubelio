import 'package:flutter/material.dart';

import 'package:technical_test/app/config/app_colors.dart';

class CustomTextfielWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? tController;
  final IconData? iconPrefix;

  final bool? obscureText;
  const CustomTextfielWidget({Key? key, this.hintText, this.tController, this.iconPrefix, this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: new BorderRadius.circular(8),
      ),
      child: TextField(
        controller: tController,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          prefixIcon: Icon(iconPrefix, color: greyColor),
          hintText: hintText,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
