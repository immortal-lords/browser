import 'package:angular/angular.dart';
import 'package:browser/src/city/city_map/battlefield_tile/tower_info/upgrade/tower_upgrade_info_component.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

@Component(
  selector: 'new-tower-info',
  styleUrls: ['new_tower_info_component.css'],
  templateUrl: 'new_tower_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    TowerUpgradeInfoComponent,
  ],
)
class NewTowerInfoComponent {
  @Input()
  City city;

  @Input()
  TowerSpec spec;

  NewTowerInfoComponent();
}
