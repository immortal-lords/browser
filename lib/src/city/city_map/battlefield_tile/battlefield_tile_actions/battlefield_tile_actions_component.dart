import 'dart:async';

import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/new_info/new_building_info_component.dart';
import 'package:browser/src/city/building_info/upgrade_info/upgrade_info_component.dart';
import 'package:browser/src/city/service.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

import 'package:browser/src/city/city_map/city_tile/city_tile.dart';

@Component(
  selector: 'battlefield-tile-actions',
  styleUrls: ['battlefield_tile_actions_component.css'],
  templateUrl: 'battlefield_tile_actions_component.html',
  providers: [],
  directives: [
    NgIf,
    NgFor,
    NgClass,
    BuildingUpgradeInfoComponent,
    NewBuildingInfoComponent,
  ],
)
class BattleFieldTileActionsComponent {
  final EmpireService empireService;

  @Input()
  City city;

  @Input()
  CityTile tile;

  final _moveController = StreamController<Tower>();

  @Output()
  Stream<Tower> get moveBuilding => _moveController.stream;

  @Input()
  bool isMoving = false;

  BattleFieldTileActionsComponent(this.empireService);

  BattleFieldEntity get entity => tile.entity;

  Tower get tower => entity is Tower ? entity : null;

  String get canUpgrade {
    if (tower == null) {
      return null;
    }

    if (tower.level >= 20) {
      return 'Max level reached';
    }

    if (!city.resources
        .hasEnough(tower.spec.constructionCost[tower.level + 1])) {
      return 'Not enough resources';
    }

    return null;
  }

  String canBuild(TowerSpec spec) {
    if (spec.minCCLevel > city.level) {
      return 'Required City center level ${spec.minCCLevel}';
    }

    if (!city.resources.hasEnough(spec.constructionCost[1])) {
      return 'Not enough resources';
    }

    return null;
  }

  Future<void> construct(TowerSpec spec) async {
    if (canBuild(spec) != null) {
      return;
    }

    _moveController.add(null);
    await empireService.constructTower(
        empireService.city.id, tile.position, spec.type);
  }

  Future<void> upgrade() async {
    if (canUpgrade != null) {
      return;
    }

    _moveController.add(null);
    await empireService.upgradeTower(
        empireService.city.id, tower.id, tower.level);
  }

  Future<void> complete() async {
    _moveController.add(null);
    await empireService.completeTowerUpgrade(
        empireService.city.id, tower.id, tower.level);
  }

  Future<void> cancel() async {
    _moveController.add(null);
    await empireService.cancelTowerUpgrade(
        empireService.city.id, tower.id, tower.level);
  }

  Future<void> demolish() async {
    _moveController.add(null);
    await empireService.demolishTower(empireService.city.id, tower.id);
  }

  void move() {
    _moveController.add(tower);
  }

  void cancelMove() {
    _moveController.add(null);
  }

  static final towers = TowerSpec.towers;
}
