import 'package:angular/angular.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';
import 'package:duration/duration.dart';

@Component(
  selector: 'lumbercamp-upgrade-info',
  styleUrls: ['lumbercamp_upgrade_info_component.css'],
  templateUrl: 'lumbercamp_upgrade_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LumberCampUpgradeInfoComponent {
  @Input()
  City city;

  @Input()
  Building building;

  LumberCampUpgradeInfoComponent();

  int get nextWoodPerHour => building.spec.production1[building.level + 1];

  int get nextWoodStorageBonus => building.spec.production2[building.level + 1];

  ConstResource get upgradeCost =>
      building.spec.constructionCost[building.level + 1];

  String get constructionTime {
    final base = building.spec.constructionDuration[building.level + 1];

    final seconds = (base.inSeconds * 100) ~/ (city.constructionSpeed + 100);
    Duration duration = Duration(seconds: seconds);
    print('here1 ${building.position} ${building.id}');

    return prettyDuration(duration,
        abbreviated: true, delimiter: ' ', spacer: '');
  }
}
