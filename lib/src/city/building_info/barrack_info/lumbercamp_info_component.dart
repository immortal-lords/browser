import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/lumbercamp_info/upgrade/lumbercamp_upgrade_info_component.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';
import 'package:duration/duration.dart';

@Component(
  selector: 'lumbercamp-building-info',
  styleUrls: ['lumbercamp_info_component.css'],
  templateUrl: 'lumbercamp_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    LumberCampUpgradeInfoComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LumberCampBuildingInfoComponent {
  @Input()
  City city;

  Building _building;

  @Input()
  set building(Building value) {
    _building = value;
    _combinedWoodPerHour();
  }

  Building get building => _building;

  LumberCampBuildingInfoComponent();

  int get woodPerHour => building.spec.production1[building.level];

  int get woodStorageBonus => building.spec.production2[building.level];

  Map<String, dynamic> combinedWoodPerHour = {};

  void _combinedWoodPerHour() {
    final neighbours = city.getNeighbours(building.position);

    int numForests = 0;

    int warehouseBonus = 0;
    final warehouseBonuses = <String>[];

    for (final neighbour in neighbours) {
      if (neighbour is CityTerrain &&
          neighbour.type == CityEntityKind.forest.name) {
        numForests++;
      } else if (neighbour is Building &&
          neighbour.type == BuildingSpec.warehouseId) {
        final bonus = neighbour.spec.production2[neighbour.level];
        warehouseBonuses.add('${bonus}%');
        warehouseBonus += bonus;
      }
    }

    final totalBonus = (numForests * 50) + warehouseBonus;
    final total = (woodPerHour * (100 + totalBonus)) ~/ 100;

    print('here ${building.position} ${building.id}');

    combinedWoodPerHour = {
      'forests': numForests,
      'warehouseBonus': warehouseBonus,
      'total': total,
      'totalBonus': totalBonus,
      'warehouseBonuses': warehouseBonuses.join(' + '),
    };
  }
}
