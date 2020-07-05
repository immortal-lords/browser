import 'package:angular/angular.dart';
import 'package:browser/src/city/city_map/city_map_component.dart';
import 'package:browser/src/city/service.dart';
import 'package:common/api.dart';

import '../city_tile/city_tile.dart';

@Component(
  selector: 'tile-actions',
  styleUrls: ['tile_actions_component.css'],
  templateUrl: 'tile_actions_component.html',
  providers: [],
  directives: [NgIf],
)
class TileActionsComponent implements AfterChanges {
  final EmpireService empireService;

  @Input()
  CityTile tile;

  TileActionsComponent(this.empireService);

  CityEntity get entity => tile.entity;

  Building get building => entity is Building ? entity : null;

  @override
  void ngAfterChanges() {
    print(building?.constructionEnd);
  }

  Future<void> upgrade() async {
    await empireService.api
        .upgrade(empireService.city.id, building.id, building.level);
  }
}
