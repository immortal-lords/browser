import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/barrack_info/upgrade/barrack_upgrade_info_component.dart';
import 'package:common/api.dart';

@Component(
  selector: 'barrack-building-info',
  styleUrls: ['barrack_info_component.css'],
  templateUrl: 'barrack_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    BarrackUpgradeInfoComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class BarrackBuildingInfoComponent {
  @Input()
  City city;

  @Input()
  Building building;

  BarrackBuildingInfoComponent();

  int get recruitmentSpeedBonus => building.spec.production1[building.level];

  int get troopCapacity => building.spec.production2[building.level];
}
