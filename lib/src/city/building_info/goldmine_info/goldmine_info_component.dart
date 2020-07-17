import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/goldmine_info/upgrade/goldmine_upgrade_info_component.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

@Component(
  selector: 'goldmine-building-info',
  styleUrls: ['goldmine_info_component.css'],
  templateUrl: 'goldmine_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    GoldMineUpgradeInfoComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class GoldMineBuildingInfoComponent {
  @Input()
  City city;

  Building _building;

  @Input()
  set building(Building value) {
    _building = value;
    _combinedGoldPerHour();
  }

  Building get building => _building;

  GoldMineBuildingInfoComponent();

  int get goldPerHour => building.spec.production1[building.level];

  int get goldStorageBonus => building.spec.production2[building.level];

  Map<String, dynamic> combinedGoldPerHour = {};

  void _combinedGoldPerHour() {
    final neighbours = city.getNeighbours(building.position);

    int numHills = 0;

    int warehouseBonus = 0;
    final warehouseBonuses = <String>[];

    for (final neighbour in neighbours) {
      if (neighbour is CityTerrain &&
          neighbour.type == CityTerrainSpec.hill.type) {
        numHills++;
      } else if (neighbour is Building &&
          neighbour.type == BuildingSpec.warehouseId) {
        final bonus = neighbour.spec.production2[neighbour.level];
        warehouseBonuses.add('${bonus}%');
        warehouseBonus += bonus;
      }
    }

    final totalBonus = (numHills * 50) + warehouseBonus;
    final total = (goldPerHour * (100 + totalBonus)) ~/ 100;

    combinedGoldPerHour = {
      'hills': numHills,
      'warehouseBonus': warehouseBonus,
      'total': total,
      'totalBonus': totalBonus,
      'warehouseBonuses': warehouseBonuses.join(' + '),
    };
  }
}
