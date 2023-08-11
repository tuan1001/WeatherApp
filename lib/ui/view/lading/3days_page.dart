import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onboarding_concept/bloc/weather/weather_bloc.dart';
import 'package:onboarding_concept/bloc/weather/weather_state.dart';
import 'package:onboarding_concept/ui/utils/colors/color.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/text.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/type_text.dart';

class ThreeDaysPage extends StatelessWidget {
  const ThreeDaysPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Column(
          children: [
            for (var items in state.weather.forecast.forecastday)
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: thirdColor, borderRadius: BorderRadius.all(Radius.circular(15))),
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextCus(
                            title: DateFormat.MMMMEEEEd().format(DateTime.parse(items.date!)),
                            typeSize: TextCusType.subtitle,
                            typeWeight: TextCusType.header,
                          ),
                          5.height,
                          Text(items.day!.condition!.text!),
                        ],
                      ).paddingAll(10),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('${items.day!.maxtempC.toString()}°'),
                                5.height,
                                Text('${items.day!.mintempC.toString()}°'),
                              ],
                            ),
                            VerticalDivider(
                              color: Colors.grey,
                              thickness: 1.5,
                            ),
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage('https:${items.day!.condition!.icon!}'), fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                      ).paddingOnly(right: 20),
                    ],
                  )),
          ],
        );
      },
    );
  }
}
