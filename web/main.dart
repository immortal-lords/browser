import 'package:angular/angular.dart';
import 'package:browser/app_component.template.dart' as ng;

import 'package:http/browser_client.dart';
import 'package:jaguar_resty/jaguar_resty.dart';

Future<void> main() async {
  globalClient = BrowserClient();

  runApp(ng.AppComponentNgFactory);
}
