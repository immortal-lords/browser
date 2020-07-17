import 'dart:async';

import 'package:angular/angular.dart';
import 'package:browser/src/city/building_info/building_info_component.dart';
import 'package:browser/src/city/city_map/city_tile/upgrade_progress/upgrade_progress_component.dart';
import 'package:browser/src/city/service.dart';
import 'package:browser/src/city/terrain_info/terrain_info_component.dart';
import 'package:common/view.dart';
import '../scaleinfo.dart';

import 'city_tile.dart';

@Component(
  selector: 'city-tile',
  styleUrls: ['city_tile_component.css'],
  templateUrl: 'city_tile_component.html',
  directives: [
    NgFor,
    NgIf,
    NgClass,
    UpgradeProgressComponent,
    BuildingInfoComponent,
    CityTerrainInfoComponent,
  ],
)
class CityTileComponent implements OnDestroy {
  CityTile _tile;

  EmpireService empireService;

  StreamSubscription<CityEntity> _tileUpdaterCanceller;

  @Input()
  City city;

  @Input()
  set tile(CityTile value) {
    if (_tileUpdaterCanceller != null) {
      _tileUpdaterCanceller.cancel();
      _tileUpdaterCanceller = null;
    }

    _tile = value;
    _tileUpdaterCanceller = _tile?.onEntityChange?.listen((event) {
      _changeDetectorRef.markForCheck();
    });
  }

  CityTile get tile => _tile;

  CityEntity get entity => _tile?.entity;

  @Input()
  Building moving;

  @HostBinding('class.moving')
  bool get isMoving => moving != null;

  @Input()
  @HostBinding('class.selected')
  bool selected = false;

  @Input()
  ScaleInfo scaleInfo;

  final _clickEmitter = StreamController<CityTile>();

  @Output()
  Stream<CityTile> get tileClicked => _clickEmitter.stream;

  ChangeDetectorRef _changeDetectorRef;

  CityTileComponent(this._changeDetectorRef, this.empireService);

  @override
  void ngOnDestroy() {
    if (_tileUpdaterCanceller != null) {
      _tileUpdaterCanceller.cancel();
      _tileUpdaterCanceller = null;
    }
  }

  CityTerrain get terrain => entity is CityTerrain ? entity : null;

  Building get building => entity is Building ? entity : null;

  void clicked() {
    _clickEmitter.add(tile);
  }
}
