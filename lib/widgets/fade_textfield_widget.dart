import 'package:flutter/material.dart';
import 'fade_container_widget.dart';

class FadeTextFieldWidget extends StatelessWidget {
  const FadeTextFieldWidget({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.height = 0.08,
    this.multiline = false,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final double height;
  final bool multiline;

  @override
  Widget build(BuildContext context) {
    return FadeContainerWidget(
      height: height,
      child: TextField(
        controller: textEditingController,
        maxLines: multiline ? 3 : 1,
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