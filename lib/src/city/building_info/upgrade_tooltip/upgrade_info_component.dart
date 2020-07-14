import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/lumbercamp_info/lumbercamp_info_component.dart';
import 'package:browser/src/city/building_info/lumbercamp_info/upgrade/lumbercamp_upgrade_info_component.dart';
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
