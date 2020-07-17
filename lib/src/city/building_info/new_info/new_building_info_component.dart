import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/barrack_info/new/barrack_new_info_component.dart';
import 'package:browser/src/city/building_info/goldmine_info/new/goldmine_new_info_component.dart';
import 'package:browser/src/city/building_info/lumbercamp_info/new/lumbercamp_new_info_component.dart';
import 'package:browser/src/city/building_info/quarry_info/new/quarry_new_info_component.dart';
import 'package:browser/src/city/building_info/warehouse_info/new/warehouse_new_info_component.dart';
import 'package:common/common.dart';

@Component(
  selector: 'new-building-info',
  styleUrls: ['new_building_info_component.css'],
  templateUrl: 'new_building_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    LumberCampNewInfoComponent,
    QuarryNewInfoComponent,
    GoldMineNewInfoComponent,
    WarehouseNewInfoComponent,
    BarrackNewInfoComponent,
  ],
  exports: [BuildingSpec],
)
class NewBuildingInfoComponent {
  @Input()
  BuildingSpec spec;

  NewBuildingInfoComponent();
}
