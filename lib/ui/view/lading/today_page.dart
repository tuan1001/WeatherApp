import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:onboarding_concept/bloc/weather/weather_bloc.dart';
import 'package:onboarding_concept/bloc/weather/weather_state.dart';
import 'package:onboarding_concept/data/model/weather.dart';
import 'package:onboarding_concept/ui/utils/widgets/containers/container_weather.dart';
import 'package:onboarding_concept/ui/utils/widgets/items/bar_chart.dart';
import 'package:onboarding_concept/ui/utils/widgets/items/line_chart.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/text.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/type_text.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  ScrollController _scrollController = ScrollController();

  void scrollToCurrentTime(List<Current> forecastHours) {
    // Get the current time
    DateTime currentTime = DateTime.now();

    // Find the index of the forecast hour that matches the current time
    int index = forecastHours.indexWhere((hour) {
      DateTime hourTime = DateTime.parse(hour.time!);
      return currentTime.hour == hourTime.hour;
    });
    print(index);

    if (index != -1) {
      // Calculate the offset for the desired index
      double offset = index * 46; // Adjust yourItemWidth as needed

      // Animate the scroll to the calculated offset
      _scrollController.animateTo(
        offset,
        duration: Duration(seconds: 1), // Adjust duration as needed
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Call scrollToCurrentTime with your forecast hours list
          scrollToCurrentTime(state.weather.forecast.forecastday.expand((day) => day.hour!).toList());
        });
        return Column(
          children: [
            Wrap(children: [
              ContainerWeather(
                title: 'Wind speed',
                data: '${state.weather.current.windKph} km/h',
                icon: Ionicons.cloud_outline,
              ),
              ContainerWeather(
                title: 'Rain change',
                data: List.generate(
                        state.weather.forecast.forecastday.length, (index) => '${state.weather.forecast.forecastday[0].day!.dailyChanceOfRain}%')
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', ''),
                icon: Ionicons.rainy_outline,
              ),
              ContainerWeather(
                title: 'Pressure',
                data: '${state.weather.current.pressureMb} mb',
                icon: Ionicons.cloud_outline,
              ),
              ContainerWeather(
                title: 'UV Index',
                data: '${state.weather.current.uv}',
                icon: Ionicons.sunny,
              ),
            ]),
            ContainerWeather(
              title: 'Hourly forecast',
              data: '',
              icon: Ionicons.time_outline,
              width: MediaQuery.of(context).size.width,
              body: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  children: [
                    for (var items1 in state.weather.forecast.forecastday)
                      for (var items2 in items1.hour!)
                        Container(
                          child: Column(
                            children: [
                              TextCus(
                                title: DateFormat.j().format(DateTime.parse(items2.time!)),
                                typeSize: TextCusType.subtitle,
                              ),
                              // TextCus(
                              //   title: DateFormat('HH').format(DateTime.parse(items2.time!)),
                              //   typeSize: TextCusType.subtitle,
                              // ),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage('https:${items2.condition!.icon!}'), fit: BoxFit.cover),
                                ),
                              ),
                              TextCus(
                                title: '${items2.tempC}°',
                                typeSize: TextCusType.subtitle,
                                typeWeight: TextCusType.header,
                              ),
                            ],
                          ),
                        ).paddingOnly(left: 15, bottom: 10)
                  ],
                ),
              ),
            ),
            ContainerWeather(
                title: 'Day forecast', width: MediaQuery.of(context).size.width, data: '', icon: Ionicons.rainy_outline, body: LineChartSample2()),
            ContainerWeather(
                title: 'Change of rain',
                width: MediaQuery.of(context).size.width,
                data: '',
                icon: Ionicons.rainy_outline,
                body: BarChartSample1(
                    data: List.generate(
                  state.weather.forecast.forecastday.length,
                  (index) => state.weather.forecast.forecastday[index],
                )))
          ],
        );
      },
    );
  }
}
