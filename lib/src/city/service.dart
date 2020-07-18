import 'dart:async';

import 'package:common/common.dart';
import 'package:common/view.dart';

class EmpireService {
  final Api _api;

  Empire _empire;

  City _city;

  final _cityUpdateEmitter = StreamController<City>();

  Stream<City> _onCityUpdate;

  Timer _cityUpdaterTimer;

  EmpireService(this._api) {
    _onCityUpdate = _cityUpdateEmitter.stream.asBroadcastStream();
  }

  Empire get empire => _empire;

  City get city => _city;

  Future<void> init() async {
    _empire = await _api.getMyEmpire();
    if (_empire.cities.isEmpty) {
      _empire = await _api.firstCity();
    }

    await changeCity(_empire.cities.first.id);
  }

  void startCityUpdate() {
    if (_cityUpdaterTimer != null) {
      stopCityUpdate();
    }

    _cityUpdaterTimer = Timer.periodic(Duration(seconds: 10), (_) async {
      await _updateCity();
      // TODO update city when building construction completes
    });
  }

  Future<void> _updateCity() async {
    _city = await _api.getMyCityById(city.id);
    _cityUpdateEmitter.add(_city);
  }

  void stopCityUpdate() {
    if (_cityUpdaterTimer == null) {
      return;
    }

    _cityUpdaterTimer.cancel();
    _cityUpdaterTimer = null;
  }

  Future<void> changeCity(int cityId) async {
    final city = await _api.getMyCityById(cityId);
    _city = city;

    _cityUpdateEmitter.add(_city);
  }

  Stream<City> get onCityUpdate => _onCityUpdate;

  Future<void> login() async {
    await _api
        .login(LoginRequest(email: 'knight@example.com', password: 'S3cr3t'));
  }

  Future<void> constructBuilding(
      int cityId, Position position, int type) async {
    await _api.constructBuilding(cityId, position, type);
    await _updateCity();
  }

  Future<void> upgradeBuilding(int cityId, int buildingId, int level) async {
    await _api.upgradeBuilding(cityId, buildingId, level);
    await _updateCity();
  }

  Future<void> completeBuildingUpgrade(
      int cityId, int buildingId, int level) async {
    await _api.completeBuildingUpgrade(cityId, buildingId);
    await _updateCity();
  }

  Future<void> cancelBuildingUpgrade(
      int cityId, int buildingId, int level) async {
    await _api.cancelBuildingUpgrade(cityId, buildingId);
    await _updateCity();
  }

  Future<void> moveBuilding(
      int cityId, int buildingId, Position newPosition) async {
    await _api.moveBuilding(cityId, buildingId, newPosition);
    await _updateCity();
  }

  Future<void> demolishBuilding(int cityId, int buildingId) async {
    await _api.demolishBuilding(cityId, buildingId);
    await _updateCity();
  }

  Future<void> constructTower(int cityId, Position position, int type) async {
    await _api.constructTower(cityId, position, type);
    await _updateCity();
  }

  Future<void> upgradeTower(int cityId, int towerId, int level) async {
    await _api.upgradeTower(cityId, towerId, level);
    await _updateCity();
  }

  Future<void> completeTowerUpgrade(int cityId, int towerId, int level) async {
    await _api.completeTowerUpgrade(cityId, towerId);
    await _updateCity();
  }

  Future<void> cancelTowerUpgrade(int cityId, int towerId, int level) async {
    await _api.cancelTowerUpgrade(cityId, towerId);
    await _updateCity();
  }

  Future<void> moveTower(
      int cityId, int buildingId, Position newPosition) async {
    await _api.moveTower(cityId, buildingId, newPosition);
    await _updateCity();
  }

  Future<void> demolishTower(int cityId, int towerId) async {
    await _api.demolishTower(cityId, towerId);
    await _updateCity();
  }
}
