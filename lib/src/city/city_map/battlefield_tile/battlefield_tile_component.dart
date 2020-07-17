import 'dart:async';

import 'package:angular/angular.dart';
import 'package:browser/src/city/city_map/city_tile/upgrade_progress/upgrade_progress_component.dart';
import 'package:browser/src/city/service.dart';
import 'package:common/view.dart';
import '../scaleinfo.dart';

import 'battlefield_tile.dart';

@Component(
  selector: 'battlefield-tile',
  styleUrls: ['battlefield_tile_component.css'],
  templateUrl: 'battlefield_tile_component.html',
  directives: [
    NgFor,
    NgIf,
    NgClass,
    UpgradeProgressComponent,
  ],
)
class BattleFieldTileComponent implements OnDestroy {
  BattleFieldTile _tile;

  EmpireService empireService;

  StreamSubscription<BattleFieldEntity> _tileUpdaterCanceller;

  @Input()
  City city;

  @Input()
  set tile(BattleFieldTile value) {
    if (_tileUpdaterCanceller != null) {
      _tileUpdaterCanceller.cancel();
      _tileUpdaterCanceller = null;
    }

    _tile = value;
    _tileUpdaterCanceller = _tile?.onEntityChange?.listen((event) {
      _changeDetectorRef.markForCheck();
    });
  }

  BattleFieldTile get tile => _tile;

  BattleFieldEntity get entity => _tile?.entity;

  @Input()
  BattleFieldEntity moving;

  @HostBinding('class.moving')
  bool get isMoving => moving != null;

  @Input()
  @HostBinding('class.selected')
  bool selected = false;

  @Input()
  ScaleInfo scaleInfo;

  final _clickEmitter = StreamController<BattleFieldTile>();

  @Output()
  Stream<BattleFieldTile> get tileClicked => _clickEmitter.stream;

  ChangeDetectorRef _changeDetectorRef;

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
