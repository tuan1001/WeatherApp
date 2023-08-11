// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:onboarding_concept/bloc/weather/weather_bloc.dart';
import 'package:onboarding_concept/bloc/weather/weather_state.dart';
import 'package:onboarding_concept/ui/utils/colors/color.dart';
import 'package:onboarding_concept/ui/utils/layout/tabar_sliver_layout.dart';
import 'package:onboarding_concept/ui/utils/widgets/dialogs/noti_dialog.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/text.dart';
import 'package:onboarding_concept/ui/utils/widgets/texts/type_text.dart';
import 'package:onboarding_concept/ui/view/lading/3days_page.dart';
import 'package:quickalert/quickalert.dart';
import 'today_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  late TabController tabController;
  late AnimationController controller;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    // BlocProvider.of<WeatherBloc>(context).add(GetWeather(
    //   q: 'jakarta',
    // ));
    BlocProvider.of<WeatherBloc>(context).add(GetForecast(
      q: 'vietnam',
      day: 7,
      hour: null,
    ));
    String date = DateFormat('HH').format(DateTime.now());
    // print('aaa $date');
    // print('aaa ${int.parse(date) + 1}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state.status == WeatherStatus.getSuccess) {
        } else if (state.status == WeatherStatus.error) {
          showQuickDialog('Thông báo', QuickAlertType.error, state.error);
        }
      },
      builder: (context, state) {
        return TabbarSliverLayout(
            tabController: tabController,
            title: '',
            scrollController: scrollController,
            expandedHeight: MediaQuery.of(context).size.height / 2.5,
            flexibleSpaceBar: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    color: themeColor, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(30))
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
            body: [
              TodayPage(),
              Container(
                child: Center(
                  child: Text('Tomorow'),
                ),
              ),
              ThreeDaysPage()
            ],
            overlayLoading: state.status == WeatherStatus.loading ? true : false,
            tabs: [
              Tab(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      'Today',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      'Tomorrow',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      '3 days',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
            onRefresh: () {
              // BlocProvider.of<WeatherBloc>(context).add(GetWeather(
              //   q: 'jakarta',
              // ));
              return Future.value();
            });
      },
    );
  }
}
