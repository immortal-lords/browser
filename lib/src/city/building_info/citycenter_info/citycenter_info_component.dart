import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/citycenter_info/upgrade/citycenter_upgrade_info_component.dart';
import 'package:common/api.dart';

@Component(
  selector: 'citycenter-building-info',
  styleUrls: ['citycenter_info_component.css'],
  templateUrl: 'citycenter_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
    CityCenterUpgradeInfoComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class CityCenterBuildingInfoComponent {
  @Input()
  City city;

  @Input()
  Building building;

  CityCenterBuildingInfoComponent();

  int get constructionSpeedBonus => building.spec.production1[building.level];

  int get tradeCarts => building.spec.production2[building.level];
}
