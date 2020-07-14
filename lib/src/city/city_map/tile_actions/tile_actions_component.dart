import 'dart:async';

import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/upgrade_tooltip/upgrade_info_component.dart';
import 'package:browser/src/city/service.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

import '../city_tile/city_tile.dart';

@Component(
  selector: 'tile-actions',
  styleUrls: ['tile_actions_component.css'],
  templateUrl: 'tile_actions_component.html',
  providers: [],
  directives: [NgIf, NgFor, BuildingUpgradeInfoComponent,],
)
class TileActionsComponent {
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

  TileActionsComponent(this.empireService);

  CityEntity get entity => tile.entity;

  Building get building => entity is Building ? entity : null;

  Future<void> construct(int type) async {
    await empireService.constructBuilding(
        empireService.city.id, tile.position, type);
  }

  Future<void> upgrade() async {
    await empireService.upgradeBuilding(
        empireService.city.id, building.id, building.level);
  }

  Future<void> complete() async {
    await empireService.completeBuildingUpgrade(
        empireService.city.id, building.id, building.level);
  }

  Future<void> cancel() async {
    await empireService.cancelBuildingUpgrade(
        empireService.city.id, building.id, building.level);
  }

  Future<void> demolish() async {
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
