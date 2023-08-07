import 'package:get_it/get_it.dart';
import 'package:onboarding_concept/data/di/di_singleton.dart';

final injector = GetIt.instance;

mixin AppInjector {
  static Future<void> initializeDependencies({required String buildMode}) async {
    await NetWorkDI.init(injector, buildMode: buildMode);
    await LocalDI.init(injector);
    await ApiDI.init(injector);
    await RepositoryDI.init(injector);
  }
}
