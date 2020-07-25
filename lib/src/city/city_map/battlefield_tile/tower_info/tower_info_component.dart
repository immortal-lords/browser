import 'package:angular/angular.dart';
import 'package:browser/src/city/city_map/battlefield_tile/tower_info/upgrade/tower_upgrade_info_component.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

@Component(
  selector: 'tower-info',
  styleUrls: ['tower_info_component.css'],
  templateUrl: 'tower_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    TowerUpgradeInfoComponent,
  ],
)
class TowerInfoComponent {
  @Input()
  City city;

  @Input()
  Tower tower;

  TowerInfoComponent();
}
