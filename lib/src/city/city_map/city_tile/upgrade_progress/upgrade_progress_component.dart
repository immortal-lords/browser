import 'dart:async';

import 'package:angular/angular.dart';
import 'package:common/api.dart';
import 'package:duration/duration.dart';

@Component(
  selector: 'upgrade-progress',
  styleUrls: ['upgrade_progress_component.css'],
  templateUrl: 'upgrade_progress_component.html',
  providers: [],
  directives: [NgIf],
)
class UpgradeProgressComponent extends ComponentState
    implements OnInit, OnDestroy {
  @Input()
  Building building;

  Timer _timer;

  UpgradeProgressComponent();

  @override
  void ngOnInit() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _updateState();
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

  String duration = '';

  num percentage = 0;

  void _updateState() {
    if (building.constructionEnd == null) {
      duration = '';
      percentage = 0;
      return;
    }

    final now = DateTime.now().toUtc();
    if (now.isAfter(building.constructionEnd)) {
      duration = '';
      percentage = 100;
      return;
    }

    final progress = now.difference(building.constructionStart);
    final total =
        building.constructionEnd.difference(building.constructionStart);
    percentage = (progress.inSeconds / total.inSeconds) * 100;
    duration = prettyDuration(building.constructionEnd.difference(now),
        abbreviated: true, first: true);
  }
}
