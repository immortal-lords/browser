import 'dart:async';

import 'package:angular/angular.dart';
import 'package:browser/src/city/city_map/city_tile/city_tile_component.dart';

@Component(
  selector: 'city-map',
  styleUrls: ['city_map_component.css'],
  templateUrl: 'city_map_component.html',
  directives: [
    NgFor,
    NgIf,
    CityTileComponent,
  ],
)
class CityMapComponent implements OnInit {
  CityMapComponent();

  @override
  Future<Null> ngOnInit() async {
  }
}
