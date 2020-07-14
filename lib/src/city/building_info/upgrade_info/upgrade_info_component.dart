import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/barrack_info/upgrade/barrack_upgrade_info_component.dart';
import 'package:browser/src/city/building_info/citycenter_info/upgrade/citycenter_upgrade_info_component.dart';
import 'package:browser/src/city/building_info/goldmine_info/upgrade/goldmine_upgrade_info_component.dart';
import 'package:browser/src/city/building_info/lumbercamp_info/upgrade/lumbercamp_upgrade_info_component.dart';
import 'package:browser/src/city/building_info/quarry_info/upgrade/quarry_upgrade_info_component.dart';
import 'package:browser/src/city/building_info/warehouse_info/upgrade/warehouse_upgrade_info_component.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

@Component(
  selector: 'building-upgrade-info',
  styleUrls: ['upgrade_info_component.css'],
  templateUrl: 'upgrade_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    LumberCampUpgradeInfoComponent,
    QuarryUpgradeInfoComponent,
    GoldMineUpgradeInfoComponent,
    WarehouseUpgradeInfoComponent,
    BarrackUpgradeInfoComponent,
    CityCenterUpgradeInfoComponent,
  ],
  exports: [BuildingSpec],
)
class BuildingUpgradeInfoComponent {
  @Input()
  City city;

  @Input()
  Building building;

  BuildingUpgradeInfoComponent();
}
