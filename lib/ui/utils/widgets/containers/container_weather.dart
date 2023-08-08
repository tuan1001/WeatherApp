import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding_concept/ui/utils/colors/color.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/text.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/type_text.dart';

class ContainerWeather extends StatelessWidget {
  final String title;
  final String data;
  final IconData icon;
  final double? width;
  final Widget? body;
  const ContainerWeather({Key? key, required this.title, required this.data, required this.icon, this.width, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width / 2.5,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(color: thirdColor, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                      child: Icon(
                    icon,
                    size: 13,
                  ).paddingAll(3))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCus(
                    title: title,
                    typeWeight: TextCusType.header,
                  ),
                  data == '' ? Container() : TextCus(title: data)
                ],
              ).paddingOnly(left: 10),
            ],
          ).paddingAll(10),
          body ?? Container()
        ],
      ),
    );
  }
}
