import 'package:angular/angular.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';
import 'package:duration/duration.dart';

@Component(
  selector: 'barrack-upgrade-info',
  styleUrls: ['barrack_upgrade_info_component.css'],
  templateUrl: 'barrack_upgrade_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class BarrackUpgradeInfoComponent {
  @Input()
  City city;

  @Input()
  Building building;

  BarrackUpgradeInfoComponent();

  int get nextRecruitmentSpeedBonus =>
      building.spec.production1[building.level + 1];

  int get nextTroopCapacity => building.spec.production2[building.level + 1];

  ConstResource get upgradeCost =>
      building.spec.constructionCost[building.level + 1];

  String get constructionTime {
    final base = building.spec.constructionDuration[building.level + 1];

    final seconds = (base.inSeconds * 100) ~/ (city.constructionSpeed + 100);
    Duration duration = Duration(seconds: seconds);

    return prettyDuration(duration,
        abbreviated: true, delimiter: ' ', spacer: '');
  }
}
