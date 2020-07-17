import 'package:angular/angular.dart';
import 'package:common/common.dart';

@Component(
  selector: 'barrack-new-info',
  styleUrls: ['barrack_new_info_component.css'],
  templateUrl: 'barrack_new_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class BarrackNewInfoComponent {
  BarrackNewInfoComponent();

  int get recruitmentSpeedBonus => BuildingSpec.barrack.production1[1];

  int get troopCapacity => BuildingSpec.barrack.production2[1];
}
