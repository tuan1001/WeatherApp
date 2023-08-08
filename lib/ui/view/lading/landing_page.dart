// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:onboarding_concept/bloc/weather/weather_bloc.dart';
import 'package:onboarding_concept/bloc/weather/weather_state.dart';
import 'package:onboarding_concept/ui/utils/colors/color.dart';
import 'package:onboarding_concept/ui/utils/layout/landing_layout.dart';
import 'package:onboarding_concept/ui/utils/widgets/containers/container_weather.dart';
import 'package:onboarding_concept/ui/utils/widgets/items/bar_chart.dart';
import 'package:onboarding_concept/ui/utils/widgets/items/line_chart.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/text.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/type_text.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    // BlocProvider.of<WeatherBloc>(context).add(GetWeather(
    //   q: 'jakarta',
    // ));
    BlocProvider.of<WeatherBloc>(context).add(GetForecast(
      q: 'vietnam',
      day: null,
      hour: null,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state.status == WeatherStatus.getSuccess) {
        } else if (state.status == WeatherStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
            ),
          );
          print(state.error.toString());
        }
      },
      builder: (context, state) {
        return MainSliverLayout(
          title: '',
          overlayLoading: state.status == WeatherStatus.loading ? true : false,
          onRefresh: () {
            // BlocProvider.of<WeatherBloc>(context).add(GetWeather(
            //   q: 'jakarta',
            // ));
            return Future.value();
          },
          expandedHeight: MediaQuery.of(context).size.height / 3,
          flexibleSpaceBar: FlexibleSpaceBar(
            background: Container(
              decoration:
                  BoxDecoration(color: themeColor, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(30))
                      // image: DecorationImage(
                      //   image: AssetImage('lib/ui/utils/assets/images/logo.jpg'),
                      //   fit: BoxFit.cover,
                      // ),
                      ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCus(
                        title: '${state.weather.location.name}, ${state.weather.location.country}',
                        typeSize: TextCusType.title,
                        color: Colors.white,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Ionicons.search,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ).paddingAll(10),
                  Row(
                    children: [
                      TextCus(
                        title: '${state.weather.current.tempC}°',
                        customSize: 50,
                        color: Colors.white,
                      ),
                      TextCus(
                        title: '${state.weather.current.condition!.text}°',
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        TextCus(
                          title: ' ${state.weather.location.localtime}',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          body: Column(
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
                width: MediaQuery.of(context).size.width,
                data: '',
                icon: Ionicons.time_outline,
                body: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
                  title: 'Change of rain', width: MediaQuery.of(context).size.width, data: '', icon: Ionicons.rainy_outline, body: BarChartSample1())
            ],
          ),
        );
      },
    );
  }
}
