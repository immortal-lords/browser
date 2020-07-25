import 'dart:async';

import 'package:angular/angular.dart';
import 'package:browser/src/city/city_map/battlefield_tile/tower_info/tower_info_component.dart';
import 'package:browser/src/city/city_map/city_tile/city_tile.dart';
import 'package:browser/src/city/city_map/city_tile/upgrade_progress/upgrade_progress_component.dart';
import 'package:browser/src/city/service.dart';
import 'package:common/view.dart';
import '../scaleinfo.dart';

@Component(
  selector: 'battlefield-tile',
  styleUrls: ['battlefield_tile_component.css'],
  templateUrl: 'battlefield_tile_component.html',
  directives: [
    NgFor,
    NgIf,
    NgClass,
    UpgradeProgressComponent,
    TowerInfoComponent,
  ],
)
class BattleFieldTileComponent implements OnDestroy {
  CityTile _tile;

  EmpireService empireService;

  StreamSubscription _tileUpdaterCanceller;

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

  BattleFieldEntity get entity => _tile?.entity;

  @Input()
  Buildable moving;

  @HostBinding('class.moving')
  bool get isMoving => moving != null && moving is Tower;

  @Input()
  @HostBinding('class.selected')
  bool selected = false;

  @Input()
  ScaleInfo scaleInfo;

  final _clickEmitter = StreamController<CityTile>();

  @Output()
  Stream<CityTile> get tileClicked => _clickEmitter.stream;

  final ChangeDetectorRef _changeDetectorRef;

  BattleFieldTileComponent(this._changeDetectorRef, this.empireService);

  @override
  void ngOnDestroy() {
    if (_tileUpdaterCanceller != null) {
      _tileUpdaterCanceller.cancel();
      _tileUpdaterCanceller = null;
    }
  }

  Tower get tower => entity is Tower ? entity : null;

  void clicked() {
    _clickEmitter.add(tile);
  }
}
