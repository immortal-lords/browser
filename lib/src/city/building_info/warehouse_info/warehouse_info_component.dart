import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/warehouse_info/upgrade/warehouse_upgrade_info_component.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

@Component(
  selector: 'warehouse-building-info',
  styleUrls: ['warehouse_info_component.css'],
  templateUrl: 'warehouse_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    WarehouseUpgradeInfoComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class WarehouseBuildingInfoComponent {
  @Input()
  City city;

  Building _building;

  @Input()
  set building(Building value) {
    _building = value;
    _combinedStorage();
  }

  Building get building => _building;

  WarehouseBuildingInfoComponent();

  int get storageCapacity => building.spec.production1[building.level];

  int get productionBonus => building.spec.production2[building.level];

  Map<String, dynamic> combinedStorage = {};

  void _combinedStorage() {
    final neighbours = city.getNeighbours(building.position);

    int woodBonus = 0;
    int stoneBonus = 0;
    int goldBonus = 0;

    for (final neighbour in neighbours) {
      if (neighbour is Building) {
        if (neighbour.type == BuildingSpec.lumberCampId) {
          woodBonus += BuildingSpec.lumberCamp.production2[neighbour.level];
        } else if (neighbour.type == BuildingSpec.quarryId) {
          stoneBonus += BuildingSpec.quarry.production2[neighbour.level];
        } else if (neighbour.type == BuildingSpec.goldMineId) {
          goldBonus += BuildingSpec.goldMine.production2[neighbour.level];
        }
      }
    }

    final woodStorage = (storageCapacity * (100 + woodBonus)) ~/ 100;
    final stoneStorage = (storageCapacity * (100 + stoneBonus)) ~/ 100;
    final goldStorage = (storageCapacity * (100 + goldBonus)) ~/ 100;

    combinedStorage = {
      'woodBonus': woodBonus,
      'stoneBonus': stoneBonus,
      'goldBonus': goldBonus,
      'woodStorage': woodStorage,
      'stoneStorage': stoneStorage,
      'goldStorage': goldStorage,
    };
  }
}
