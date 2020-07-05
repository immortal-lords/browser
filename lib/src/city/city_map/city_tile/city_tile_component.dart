import 'dart:async';

import 'package:angular/angular.dart';
import 'package:browser/src/city/service.dart';
import 'package:common/view.dart';

import 'city_tile.dart';

@Component(
  selector: 'city-tile',
  styleUrls: ['city_tile_component.css'],
  templateUrl: 'city_tile_component.html',
  directives: [
    NgFor,
    NgIf,
    NgClass,
  ],
)
class CityTileComponent implements OnInit, OnDestroy {
  CityTile _tile;

  EmpireService empireService;

  StreamSubscription<CityEntity> _tileUpdaterCanceller;

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
  num scale = 1;

  ChangeDetectorRef _changeDetectorRef;

  CityTileComponent(this._changeDetectorRef, this.empireService);

  @override
  Future<Null> ngOnInit() async {}

  @override
  void ngOnDestroy() {
    if (_tileUpdaterCanceller != null) {
      _tileUpdaterCanceller.cancel();
      _tileUpdaterCanceller = null;
    }
  }

  @HostListener('click')
  void clickHandler() {
  }

  @HostBinding('style.width.px')
  int get width => (100 * scale).toInt();

  @HostBinding('style.height.px')
  int get height => (100 * scale).toInt();

  CityTerrain get terrain => entity is CityTerrain ? entity : null;

  Building get building => entity is Building ? entity : null;
}
