import 'package:flutter/material.dart';

import 'fade_container_widget.dart';

class FadeTextFieldWidget extends StatelessWidget {
  const FadeTextFieldWidget({
    super.key,
    required this.textEditingController,
    required this.hintText,
  });

  final TextEditingController textEditingController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return FadeContainerWidget(
      child: TextField(
        controller: textEditingController,
        cursorColor: Colors.white,
        style: const TextStyle(fontSize: 24, color: Colors.white),
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 24, color: Colors.white.withOpacity(0.7))
        ),
      ),
    );
  }
}