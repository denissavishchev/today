import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:today/widgets/icon_svg_widget.dart';
import 'package:today/widgets/side_button_widget.dart';
import '../constants.dart';
import '../model/boxes.dart';
import '../model/water_model.dart';
import '../pages/water_settings_page.dart';
import '../providers/water_provider.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterProvider>(
        builder: (context, data, _){
          return ValueListenableBuilder(
              valueListenable: Boxes.addWaterSettingsToBase().listenable(),
              builder: (context, box, _){
                final settings = box.values.toList().cast<WaterSettingsModel>();
                return SideButtonWidget(
                  width: 100,
                  both: true,
                  onTap: () {
                    data.target = settings.isEmpty ? 0 : settings[0].target;
                    data.weight = settings.isEmpty ? '000' : settings[0].weight;
                    data.initialWakeUpTime = settings.isEmpty
                        ? const TimeOfDay(hour: 8, minute: 00)
                        : TimeOfDay(hour:int.parse((settings[0].wakeUpTime).split(":")[0]),
                        minute: int.parse((settings[0].wakeUpTime).split(":")[1]));
                    data.initialBedTime = settings.isEmpty
                        ? const TimeOfDay(hour: 22, minute: 00)
                        : TimeOfDay(hour:int.parse((settings[0].bedTime).split(":")[0]),
                        minute: int.parse((settings[0].bedTime).split(":")[1]));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) =>
                        const WaterSettingsPage()));
                  },

                  child: const IconSvgWidget(icon: 'gear', padding: 6,),);
              });
        });
  }
}