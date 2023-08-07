mixin Routes {
  static const String back = '/..';
  static const String landing = '/landing';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String profile = '/profile';
}

mixin AppPages {
  static final routes = [
    //GetPage(name: Routes.landing, page: () => const LandingScreen(), transition: Transition.fade),
    // GetPage(name: Routes.login, page: () => const LoginPage(), transition: Transition.fadeIn),
    // GetPage(name: Routes.register, page: () => const ResgisterPage(), transition: Transition.rightToLeft),
    // GetPage(name: Routes.forgotPassword, page: () => const ForgotPage(), transition: Transition.leftToRight),
    // GetPage(name: Routes.home, page: () => const HomeScreen(), transition: Transition.topLevel),
  ];
}
