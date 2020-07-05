import 'package:angular/angular.dart';
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
class TileActionsComponent {
  final EmpireService empireService;

  @Input()
  CityTile tile;

  TileActionsComponent(this.empireService);

  CityEntity get entity => tile.entity;

  Building get building => entity is Building ? entity : null;

  Future<void> construct(int type) async {
    await empireService.constructBuilding(
        empireService.city.id, tile.position, type);
  }

  Future<void> upgrade() async {
    await empireService.upgradeBuilding(
        empireService.city.id, building.id, building.level);
  }

  Future<void> demolish() async {
    await empireService.demolishBuilding(empireService.city.id, building.id);
  }
}
