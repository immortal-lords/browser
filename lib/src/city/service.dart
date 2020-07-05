import 'dart:async';

import 'package:common/view.dart';

class EmpireService {
  final Api api;

  Empire _empire;

  City _city;

  final _cityUpdateEmitter = StreamController<City>();

  Stream<City> _onCityUpdate;

  Timer _cityUpdaterTimer;

  EmpireService(this.api) {
    _onCityUpdate = _cityUpdateEmitter.stream.asBroadcastStream();
  }

  Empire get empire => _empire;

  City get city => _city;

  Future<void> init() async {
    _empire = await api.getMyEmpire();
    print(_empire);
    if (_empire.cities.isEmpty) {
      // TODO create city
      return;
    }

    await changeCity(_empire.cities.first.id);
  }

  void startCityUpdate() {
    if (_cityUpdaterTimer != null) {
      stopCityUpdate();
    }

    _cityUpdaterTimer = Timer.periodic(Duration(seconds: 10), (_) async {
      _city = await api.getMyCityById(city.id);

      _cityUpdateEmitter.add(_city);
    });
  }

  void stopCityUpdate() {
    if (_cityUpdaterTimer == null) {
      return;
    }

    _cityUpdaterTimer.cancel();
    _cityUpdaterTimer = null;
  }

  Future<void> changeCity(int cityId) async {
    final city = await api.getMyCityById(cityId);
    _city = city;

    _cityUpdateEmitter.add(_city);
  }

  Stream<City> get onCityUpdate => _onCityUpdate;
}
