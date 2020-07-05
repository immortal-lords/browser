import 'package:angular/angular.dart';

@Component(
  selector: 'resource-progress-view',
  styleUrls: ['resource_progress_view_component.css'],
  templateUrl: 'resource_progress_view_component.html',
  providers: [],
  directives: [NgIf, NgClass],
)
class ResourceProgressView {
  @Input()
  String resource;

  @Input()
  int rate;

  @Input()
  int max;

  @Input()
  int current;

  ResourceProgressView();

  num get progress {
    if(max == 0) {
      return 100;
    }

    final ret = (current / max) * 100;
    if(ret > 100) {
      return 100;
    }
    return ret;
  }

  String get maxInK => '${max~/1000}K';

  String get rateStr {
    if(rate < 2000) {
      return '${rate}';
    } else {
      // TODO 1 digit decimal precision
      return '${rate~/1000}K';
    }
  }
}
