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
  ],
  exports: [BuildingSpec],
)
class RecruitmentComponent {
  final EmpireService service;

  @Input()
  City city;

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

  static const specs = WarriorSpec.specs;
}
