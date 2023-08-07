import 'package:onboarding_concept/data/di/injector.dart';

mixin AppConfig {
  static Future<dynamic> init() async {
    //await dotenv.load(fileName: BaseUrl.envDev);
    await AppInjector.initializeDependencies(buildMode: 'dev');
  }
}
