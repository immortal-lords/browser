import 'package:angular/angular.dart';
import 'package:browser/src/city/city_map/city_map_component.dart';

// AngularDart info: https://angulardart.dev
// Components info: https://angulardart.dev/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [CityMapComponent],
)
class AppComponent {
  // Nothing here yet. All logic is in TodoListComponent.
}
