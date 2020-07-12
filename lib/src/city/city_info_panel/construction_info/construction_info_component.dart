import 'package:angular/angular.dart';
import 'package:common/api.dart';

@Component(
  selector: 'city-construction-info',
  styleUrls: ['construction_info_component.css'],
  templateUrl: 'construction_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
  ],
)
class CityConstructionInfoComponent {
  @Input()
  City city;

  CityConstructionInfoComponent();
}
