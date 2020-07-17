import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/lumbercamp_info/upgrade/lumbercamp_upgrade_info_component.dart';
import 'package:common/common.dart';

@Component(
  selector: 'lumbercamp-new-info',
  styleUrls: ['lumbercamp_new_info_component.css'],
  templateUrl: 'lumbercamp_new_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    LumberCampUpgradeInfoComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LumberCampNewInfoComponent {
  LumberCampNewInfoComponent();

  int get woodPerHour => BuildingSpec.lumberCamp.production1[1];

  int get woodStorageBonus => BuildingSpec.lumberCamp.production2[1];
}
