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
    if (max == 0) {
      return 100;
    }

    final ret = (current / max) * 100;
    if (ret > 100) {
      return 100;
    }
    return ret;
  }

  String get maxInK {
    if (max < 10000) {
      return '${max}';
    }
    return '${(max / 1000).toStringAsFixed(1)}K';
  }
}
