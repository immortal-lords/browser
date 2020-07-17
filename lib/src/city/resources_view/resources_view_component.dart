import 'dart:async';

import 'package:angular/angular.dart';
import 'package:browser/src/city/resources_view/resource_progress_view/resource_progress_view_component.dart';
import 'package:common/api.dart';

@Component(
  selector: 'resources-view',
  styleUrls: ['resources_view_component.css'],
  templateUrl: 'resources_view_component.html',
  providers: [],
  directives: [
    NgIf,
    ResourceProgressView,
  ],
)
class ResourcesViewComponent extends ComponentState
    implements OnInit, OnDestroy {
  @Input()
  LazyResource resources;

  Resource current = Resource();

  Timer _timer;

  ResourcesViewComponent();

  @override
  void ngOnInit() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _update();
      });
    });
  }

  @override
  void ngOnDestroy() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void _update() {
    final now = DateTime.now();
    current = resources.resourcesAt(now);
  }
}
