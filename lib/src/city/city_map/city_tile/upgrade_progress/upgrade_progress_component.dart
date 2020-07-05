import 'package:angular/angular.dart';
import 'package:browser/src/city/service.dart';

@Component(
  selector: 'my-app',
  styleUrls: ['upgrade_progress_component.css'],
  templateUrl: 'upgrade_progress_component.html',
  providers: [
  ],
  directives: [NgIf],
)
class UpgradeProgressComponent {
  final EmpireService service;

  UpgradeProgressComponent(this.service);
}
