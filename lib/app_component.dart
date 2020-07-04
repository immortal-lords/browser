import 'package:angular/angular.dart';
import 'package:browser/src/city/city_map/city_map_component.dart';
import 'package:browser/src/city/service.dart';
import 'package:common/api.dart';

Api makeApi() {
  final api = Api(baseUrl: 'http://localhost:15000/');
  return api;
}

EmpireService makeEmpireService(Api api) => EmpireService(api);

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  providers: [
    FactoryProvider(Api, makeApi),
    FactoryProvider(EmpireService, makeEmpireService),
  ],
  directives: [CityMapComponent, NgIf],
)
class AppComponent implements OnInit {
  final EmpireService service;
  AppComponent(this.service);

  bool waitingLogin = true;

  @override
  void ngOnInit() async {
    await service.api
        .login(LoginRequest(email: 'knight@example.com', password: 'S3cr3t'));

    await service.init();
    service.startCityUpdate();

    waitingLogin = false;
  }
}
