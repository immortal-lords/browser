import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/warehouse_info/upgrade/warehouse_upgrade_info_component.dart';
import 'package:common/common.dart';

@Component(
  selector: 'warehouse-new-info',
  styleUrls: ['warehouse_new_info_component.css'],
  templateUrl: 'warehouse_new_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    WarehouseUpgradeInfoComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class WarehouseNewInfoComponent {
  WarehouseNewInfoComponent();

  int get storageCapacity => BuildingSpec.warehouse.production1[1];

  int get productionBonus => BuildingSpec.warehouse.production2[1];
}
