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
  });

  final IconData icon;
  final String text;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoProvider>(
        builder: (context, data, child){
          return GestureDetector(
            onTap: (){
              data.changeListValue(text);
              print(selectedList);
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
                    Text(text, style: selectStyle),
                    const Spacer(),
                    Text(count.toString(), style: selectStyle,),
                  ],
                ),
              ),
            ),
          );
        });
  }
}