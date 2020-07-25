import 'package:angular/angular.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';
import 'package:duration/duration.dart';

@Component(
  selector: 'tower-upgrade-info',
  styleUrls: ['tower_upgrade_info_component.css'],
  templateUrl: 'tower_upgrade_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class TowerUpgradeInfoComponent {
  @Input()
  City city;

  @Input()
  Tower tower;

  TowerUpgradeInfoComponent();

  TowerSpec get spec => tower.spec;

  int get nextFullHp => spec.hp[tower.level + 1];

  int get nextArmor => spec.armor[tower.level + 1];

  int get nextPierceArmor => spec.pierceArmor[tower.level + 1];

  int get nextDamage => tower.spec.damage[tower.level + 1];

  ConstResource get upgradeCost => tower.spec.constructionCost[tower.level + 1];

  String get constructionTime {
    final base = tower.spec.constructionDuration[tower.level + 1];

    final seconds = (base.inSeconds * 100) ~/ (city.constructionSpeed + 100);
    Duration duration = Duration(seconds: seconds);

    return prettyDuration(duration,
        abbreviated: true, delimiter: ' ', spacer: '');
  }
}
