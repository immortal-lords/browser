import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:browser/src/city/city_info_panel/info_panel_component.dart';
import 'package:browser/src/city/city_map/battlefield_tile/battlefield_tile_actions/battlefield_tile_actions_component.dart';
import 'package:browser/src/city/city_map/battlefield_tile/battlefield_tile_component.dart';
import 'package:browser/src/city/city_map/city_tile/city_tile.dart';
import 'package:browser/src/city/city_map/city_tile/city_tile_component.dart';
import 'package:browser/src/city/city_map/scaleinfo.dart';
import 'package:browser/src/city/city_map/building_tile_actions/building_tile_actions_component.dart';
import 'package:browser/src/city/recruitment/recruitment_component.dart';
import 'package:browser/src/city/service.dart';
import 'package:common/api.dart';
import 'package:common/common.dart';

@Component(
  selector: 'city-map',
  styleUrls: ['city_map_component.css'],
  templateUrl: 'city_map_component.html',
  directives: [
    NgFor,
    NgIf,
    CityTileComponent,
    BuildingTileActionsComponent,
    BattleFieldTileActionsComponent,
    CityInfoPanelComponent,
    BattleFieldTileComponent,
    RecruitmentComponent,
  ],
)
class CityMapComponent implements OnInit, OnDestroy {
  final EmpireService service;

  StreamSubscription<City> _cityUpdateCanceller;

  StreamSubscription _windowResizeCanceller;

  bool showRecruitmentWindow = false;

  CityMapComponent(this.service) {
    _windowResizeCanceller = window.onResize.listen((event) {
      _updateLandCenter();
    }); // TODO cancel subscription

    _cityUpdateCanceller = service.onCityUpdate.listen(_updateCity);
  }

  ScaleInfo scaleInfo = ScaleInfo.scales.last;

  final List<List<CityTile>> tiles =
      CityTile.makeTiles(numColsInCity, numRowsInCity + numRowsInBattleField);

  @override
  Future<void> ngOnInit() async {
    _updateLandCenter();
  }

  City city;

  void _updateCity(City city) {
    this.city = city;
    for (int r = 0; r < tiles.length; r++) {
      final row = tiles[r];
      for (int c = 0; c < row.length; c++) {
        final tile = row[c];

        final entity = city.children[tile.position];
        tile.entity = entity;
      }
    }
  }

  DateTime _lastScaleChange = DateTime.now();

  @HostListener('wheel')
  void handleWheel(WheelEvent event) {
    final now = DateTime.now();
    if (now.difference(_lastScaleChange) < Duration(milliseconds: 500)) {
      return;
    }
    _lastScaleChange = now;

    int index = ScaleInfo.scales.indexOf(scaleInfo);
    if (index == -1) index = ScaleInfo.scales.length - 1;

    if (event.deltaY.isNegative) {
      index--;
    } else {
      index++;
    }

    if (index < 0) index = 0;
    if (index >= ScaleInfo.scales.length) index = ScaleInfo.scales.length - 1;

    scaleInfo = ScaleInfo.scales[index];

    _updateLandCenter();
  }

  void _updateLandCenter() {
    int offsetX = _landOffset.x;
    int offsetY = _landOffset.y;

    if (_panStart != null) {
      offsetX += (_panCurrent.x - _panStart.x);
      offsetY += (_panCurrent.y - _panStart.y);
    }

    landCenter = Point<int>(
        ((window.innerWidth - scaleInfo.landWidth) ~/ 2) + offsetX,
        ((window.innerHeight - scaleInfo.landHeight) ~/ 2) + offsetY);
  }

  Point<int> landCenter = Point<int>(0, 0);

  Point<int> _landOffset = Point<int>(0, 0);

  Point<int> _panStart;
  Point<int> _panCurrent;

  void beginPan(MouseEvent event) {
    if (event.button != 0) {
      return;
    }

    _panStart = _panCurrent = Point<int>(event.client.x, event.client.y);

    event.preventDefault();
    event.stopPropagation();
    event.stopImmediatePropagation();
  }

  @HostListener('mousemove')
  void mouseMoveHandler(MouseEvent event) {
    if (event.button != 0) {
      return;
    }

    if (_panStart == null) {
      return;
    }

    _panCurrent = Point<int>(event.client.x, event.client.y);

    _updateLandCenter();
  }

  @HostListener('mouseup')
  void panEnd(MouseEvent event) {
    if (_panStart == null) {
      return;
    }

    _landOffset = Point<int>(_landOffset.x + (_panCurrent.x - _panStart.x),
        _landOffset.y + (_panCurrent.y - _panStart.y));

    _panStart = _panCurrent = null;

    _updateLandCenter();

    event.stopImmediatePropagation();
    event.stopPropagation();
    event.preventDefault();
  }

  CityTile _selectedTile;

  CityTile get selectedTile => _selectedTile;

  Buildable moving;

  Future<void> tileSelected(CityTile tile) async {
    if (moving != null) {
      if (tile.entity != null) {
        window.alert('Can only move buildings to empty tiles');
        return;
      }

      final tmp = moving;
      moving = null;
      if (tile.isIndustrialSpot) {
        await service.moveBuilding(city.id, tmp.id, tile.position);
      } else {
        await service.moveTower(city.id, tmp.id, tile.position);
      }
    }

    if (_selectedTile?.position == tile.position) {
      _selectedTile = null;
      return;
    }
    _selectedTile = tile;
  }

  void startMoveBuilding(CityEntity entity) {
    moving = entity;
  }

  @override
  void ngOnDestroy() {
    _cityUpdateCanceller?.cancel();
    _windowResizeCanceller?.cancel();
  }

  void showRecruitment() {
    showRecruitmentWindow = true;
  }
}
