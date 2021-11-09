import 'package:injectable/injectable.dart';
import 'package:farmer_app/injection/injection.config.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

//@injectableInit
/*void configureInjection(String environment) {
  $initGetIt(getIt, environment: environment);
}*/
@injectableInit
void configureInjection(String environment) {
  $initGetIt(getIt, environment: environment);
}

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
  static const testenv = 'testenv';
}
