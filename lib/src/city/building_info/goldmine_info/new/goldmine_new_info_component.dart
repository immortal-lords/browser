import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/goldmine_info/upgrade/goldmine_upgrade_info_component.dart';
import 'package:common/common.dart';

@Component(
  selector: 'goldmine-new-info',
  styleUrls: ['goldmine_new_info_component.css'],
  templateUrl: 'goldmine_new_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    GoldMineUpgradeInfoComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class GoldMineNewInfoComponent {
  GoldMineNewInfoComponent();

  int get goldPerHour => BuildingSpec.goldMine.production1[1];

  int get goldStorageBonus => BuildingSpec.goldMine.production2[1];
}
