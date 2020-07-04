import 'package:angular/angular.dart';
import 'package:browser/app_component.template.dart' as ng;
import 'package:browser/src/city/service.dart';

import 'package:common/api.dart';

import 'package:http/browser_client.dart';
import 'package:jaguar_resty/jaguar_resty.dart';

import 'main.template.dart' as self;

/*
Future<void> makeApi() async {
  final api = Api(baseUrl: 'http://localhost:15000/');

  await api
      .login(LoginRequest(email: 'knight@example.com', password: 'S3cr3t'));
  final empire = await api.getMyEmpire();
  print(empire);

  return api;
}

EmpireService makeEmpireService(Api api) => EmpireService(api);

@GenerateInjector([
  FactoryProvider(Api, makeApi),
  FactoryProvider(EmpireService, makeEmpireService),
])
final InjectorFactory injector = self.injector$Injector;
 */

Future<void> main() async {
  globalClient = BrowserClient();

  runApp(ng.AppComponentNgFactory);
}
