import 'dart:async';

import 'package:angular/angular.dart';
import 'package:browser/src/city/service.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

@Component(
  selector: 'recruitment-view',
  styleUrls: ['recruitment_component.css'],
  templateUrl: 'recruitment_component.html',
  providers: [],
  directives: [
    NgIf,
    NgFor,
    NgClass,
    RecruitmentProgressBarComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class RecruitmentComponent {
  final EmpireService service;

  @Input()
  City city;

  final _closeController = StreamController();

  @Output()
  Stream get close => _closeController.stream;

  RecruitmentComponent(this.service);

  Future<void> recruit(int type) async {
    await service.recruit(city.id, type, 1);
  }

  Future<void> dismissTroops(int type) async {
    await service.dismissFighters(city.id, type, 1);
  }

  Future<void> cancelRecruitment(int recruitmentId) async {
    await service.cancelRecruitment(city.id, recruitmentId);
  }

  Future<void> completeRecruitment(int recruitmentId) async {
    await service.completeRecruitment(city.id, recruitmentId);
  }

  void closeClicked() {
    _closeController.add(null);
  }

  static const specs = WarriorSpec.specs;
}

@Component(
  selector: 'recruiting-progress-bar',
  styles: [
    '''
:host {
    display: block;
    width: calc(100% - 6px);
    height: 8px;
    background-color: rgb(0,0,0);
    border: 1px solid #f7f7f7;
    box-shadow: 0px 0px 4px 2px #ffffffad;
    position: absolute;
    left: 9px;
    top: -5px;
}

.container {
    position: relative;
    width: 100%;
    height: 100%;
}

.highlight {
    width: 100%;
    height: 45%;
    background-color: rgba(255, 255, 255, 0.58);
    position: absolute;
}

.fill {
    height: 100%;
    background-color: #c938d4;
    position: absolute;
    left: 0px;
    top: 0px;
}

.fill.finished {
    background-color: #6cd66c;
    animation: pulse 1s ease-in 0s infinite alternate;
}

@keyframes pulse {
  from {background-color: #2a7733;}
  to {background-color: #6cd66c;}
}

.duration {
    text-align: center;
    color: white;
    position: absolute;
    left: 0px;
    top: -8px;
    width: 100%;
    font-weight: bold;
    text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000, 1px 1px 0 #000;
    font-size: 13px;
}
    '''
  ],
  template: '''
  <div class="container">
      <div class="fill" [style.width.%]="percentage" [class.finished]="hasFinished"></div>
      <div class="highlight"></div>
      <div class="duration">{{timeLeftStr}}</div>
  </div>
  ''',
  providers: [],
  directives: [
    NgIf,
    NgFor,
    NgClass,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class RecruitmentProgressBarComponent extends ComponentState implements OnDestroy {
  @Input()
  Recruiting recruiting;

  Timer _timer;

  RecruitmentProgressBarComponent() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _update();
      });
    });
  }

  void _update() {
    percentage = recruiting.percentage;
    hasFinished = recruiting.hasFinished;
    timeLeftStr = recruiting.timeLeftStr;
  }

  double percentage = 0;

  bool hasFinished = false;

  String timeLeftStr = '';

  @override
  void ngOnDestroy() {
    _timer.cancel();
  }
}