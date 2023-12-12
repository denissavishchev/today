import 'package:flutter/material.dart';

import '../constants.dart';
import 'basic_container_widget.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key, required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(18, 18 ,18, size.height * 0.5),
      child: BasicContainerWidget(
        height: 200,
        child: SizedBox(
            width: 250,
            height: 180,
            child: Center(
              child: Text(
                description,
                textAlign: TextAlign.center, style: kOrangeStyle,),
            )),
      ),
    );
  }
}