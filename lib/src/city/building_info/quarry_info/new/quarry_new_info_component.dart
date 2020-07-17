import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/quarry_info/upgrade/quarry_upgrade_info_component.dart';
import 'package:common/common.dart';

@Component(
  selector: 'quarry-new-info',
  styleUrls: ['quarry_new_info_component.css'],
  templateUrl: 'quarry_new_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    QuarryUpgradeInfoComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class QuarryNewInfoComponent {
  QuarryNewInfoComponent();

  int get stonePerHour => BuildingSpec.quarry.production1[1];

  int get stoneStorageBonus => BuildingSpec.quarry.production2[1];
}
