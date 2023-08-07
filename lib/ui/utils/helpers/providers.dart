import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_concept/bloc/weather/weather_bloc.dart';

class AppProviders extends StatelessWidget {
  final Widget _child;
  const AppProviders({required Widget child}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBloc()),
      ],
      child: _child,
    );
  }
}
