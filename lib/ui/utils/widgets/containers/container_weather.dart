import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:onboarding_concept/ui/utils/colors/color.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/text.dart';

class ContainerWeather extends StatelessWidget {
  const ContainerWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(color: thirdColor, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(child: Icon(Ionicons.cloudy_night_outline).paddingAll(3))),
          Column(
            children: [TextCus(title: 'Wind speed'), TextCus(title: '12km/h')],
          )
        ],
      ).paddingAll(10),
    );
  }
}
