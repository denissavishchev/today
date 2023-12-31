import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today/constants.dart';
import '../providers/to_do_provider.dart';
import 'fade_container_widget.dart';

class SelectListWidget extends StatelessWidget {
  const SelectListWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.count,
    required this.onTap,
    this.visible = true,
  });

  final IconData icon;
  final String text;
  final int count;
  final Function() onTap;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoProvider>(
        builder: (context, data, child){
          return GestureDetector(
            onTap: (){
              onTap();
              Navigator.of(context).pop();
            },
            child: FadeContainerWidget(
              margin: 4,
              height: 0.07,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Icon(icon, size: 30, color: kWhite,),
                    const SizedBox(width: 12,),
                    Text(text, style: kWhiteStyle),
                    const Spacer(),
                    Visibility(
                      visible: visible,
                        child: Text(count.toString(), style: kWhiteStyle,)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}