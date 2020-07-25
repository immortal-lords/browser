import 'package:angular/angular.dart';
import 'package:browser/src/city/city_info_panel/construction_info/construction_info_component.dart';
import 'package:browser/src/city/city_info_panel/resources_view/resources_view_component.dart';
import 'package:common/api.dart';

@Component(
  selector: 'city-info-panel',
  styleUrls: ['info_panel_component.css'],
  templateUrl: 'info_panel_component.html',
  providers: [],
  directives: [
    CityConstructionInfoComponent,
    ResourcesViewComponent,
  ],
)
class CityInfoPanelComponent {
  @Input()
  City city;

  CityInfoPanelComponent();
}
