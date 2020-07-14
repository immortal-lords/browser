import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/citycenter_info/citycenter_info_component.dart';
import 'package:browser/src/city/building_info/goldmine_info/goldmine_info_component.dart';
import 'package:browser/src/city/building_info/lumbercamp_info/lumbercamp_info_component.dart';
import 'package:browser/src/city/building_info/quarry_info/quarry_info_component.dart';
import 'package:browser/src/city/building_info/warehouse_info/warehouse_info_component.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

@Component(
  selector: 'building-info',
  styleUrls: ['building_info_component.css'],
  templateUrl: 'building_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    CityCenterBuildingInfoComponent,
    LumberCampBuildingInfoComponent,
    QuarryBuildingInfoComponent,
    GoldMineBuildingInfoComponent,
    WarehouseBuildingInfoComponent,
  ],
  exports: [BuildingSpec],
)
class BuildingInfoComponent {
  @Input()
  City city;

  @Input()
  Building building;

  BuildingInfoComponent();
}
