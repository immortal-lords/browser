import 'package:angular/angular.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

@Component(
  selector: 'city-terrain-info',
  styleUrls: ['terrain_info_component.css'],
  templateUrl: 'terrain_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
  ],
  exports: [BuildingSpec],
)
class CityTerrainInfoComponent {
  @Input()
  City city;

  @Input()
  CityTerrain terrain;

  CityTerrainInfoComponent();
}
