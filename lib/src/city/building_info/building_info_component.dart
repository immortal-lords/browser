import 'package:angular/angular.dart';
import 'package:common/api.dart';

@Component(
  selector: 'building-info',
  styleUrls: ['building_info_component.css'],
  templateUrl: 'building_info_component.html',
  providers: [],
  directives: [
    NgIf,
    NgClass,
  ],
)
class BuildingInfoComponent {
  @Input()
  Building building;

  BuildingInfoComponent();
}
