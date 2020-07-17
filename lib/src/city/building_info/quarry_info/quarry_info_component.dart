import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/quarry_info/upgrade/quarry_upgrade_info_component.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

@Component(
  selector: 'quarry-building-info',
  styleUrls: ['quarry_info_component.css'],
  templateUrl: 'quarry_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    QuarryUpgradeInfoComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class QuarryBuildingInfoComponent {
  @Input()
  City city;

  Building _building;

  @Input()
  set building(Building value) {
    _building = value;
    _combinedStonePerHour();
  }

  Building get building => _building;

  QuarryBuildingInfoComponent();

  int get stonePerHour => building.spec.production1[building.level];

  int get stoneStorageBonus => building.spec.production2[building.level];

  Map<String, dynamic> combinedStonePerHour = {};

  void _combinedStonePerHour() {
    final neighbours = city.getNeighbours(building.position);

    int numMountains = 0;

    int warehouseBonus = 0;
    final warehouseBonuses = <String>[];

    for (final neighbour in neighbours) {
      if (neighbour is CityTerrain &&
          neighbour.type == CityTerrainSpec.mountain.type) {
        numMountains++;
      } else if (neighbour is Building &&
          neighbour.type == BuildingSpec.warehouseId) {
        final bonus = neighbour.spec.production2[neighbour.level];
        warehouseBonuses.add('${bonus}%');
        warehouseBonus += bonus;
      }
    }

    final totalBonus = (numMountains * 50) + warehouseBonus;
    final total = (stonePerHour * (100 + totalBonus)) ~/ 100;

    combinedStonePerHour = {
      'mountains': numMountains,
      'warehouseBonus': warehouseBonus,
      'total': total,
      'totalBonus': totalBonus,
      'warehouseBonuses': warehouseBonuses.join(' + '),
    };
  }
}
