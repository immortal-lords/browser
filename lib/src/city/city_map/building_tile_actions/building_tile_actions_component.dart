import 'dart:async';

import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/new_info/new_building_info_component.dart';
import 'package:browser/src/city/building_info/upgrade_info/upgrade_info_component.dart';
import 'package:browser/src/city/service.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

import '../city_tile/city_tile.dart';

@Component(
  selector: 'building-tile-actions',
  styleUrls: ['building_tile_actions_component.css'],
  templateUrl: 'building_tile_actions_component.html',
  providers: [],
  directives: [
    NgIf,
    NgFor,
    NgClass,
    BuildingUpgradeInfoComponent,
    NewBuildingInfoComponent,
  ],
)
class BuildingTileActionsComponent {
  final EmpireService empireService;

  @Input()
  City city;

  @Input()
  CityTile tile;

  @Input()
  bool isMoving = false;

  final _moveController = StreamController<Building>();

  @Output()
  Stream<Building> get moveBuilding => _moveController.stream;

  BuildingTileActionsComponent(this.empireService);

  IndustrialEntity get entity => tile.entity;

  Building get building => entity is Building ? entity : null;

  String get canUpgrade {
    if (building == null) {
      return null;
    }

    if (building.level >= 20) {
      return 'Max level reached';
    }

    if (!city.resources
        .hasEnough(building.spec.constructionCost[building.level + 1])) {
      return 'Not enough resources';
    }

    return null;
  }

  String canBuild(BuildingSpec spec) {
    if (spec.minCCLevel > city.level) {
      return 'Required City center level ${spec.minCCLevel}';
    }

    if (!city.resources.hasEnough(spec.constructionCost[1])) {
      return 'Not enough resources';
    }

    return null;
  }

  Future<void> construct(BuildingSpec spec) async {
    if (canBuild(spec) != null) {
      return;
    }

    _moveController.add(null);
    await empireService.constructBuilding(
        empireService.city.id, tile.position, spec.type);
  }

  Future<void> upgrade() async {
    if (canUpgrade != null) {
      return;
    }

    _moveController.add(null);
    await empireService.upgradeBuilding(
        empireService.city.id, building.id, building.level);
  }

  Future<void> complete() async {
    _moveController.add(null);
    await empireService.completeBuildingUpgrade(
        empireService.city.id, building.id, building.level);
  }

  Future<void> cancel() async {
    _moveController.add(null);
    await empireService.cancelBuildingUpgrade(
        empireService.city.id, building.id, building.level);
  }

  Future<void> demolish() async {
    _moveController.add(null);
    await empireService.demolishBuilding(empireService.city.id, building.id);
  }

  void move() {
    _moveController.add(building);
  }

  void cancelMove() {
    _moveController.add(null);
  }

  static final buildings = BuildingSpec.buildings;
}
