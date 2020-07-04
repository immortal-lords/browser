import 'dart:async';

import 'package:common/common.dart';
import 'package:common/view.dart';

class CityTile {
  final Position position;

  CityEntity _entity;

  final _entityChanged = StreamController<CityEntity>();

  Stream<CityEntity> _entityChangedStream;

  CityTile(this.position) {
    _entityChangedStream = _entityChanged.stream.asBroadcastStream();
  }

  CityEntity get entity => _entity;

  Stream<CityEntity> get onEntityChange => _entityChangedStream;

  set entity(CityEntity value) {
    if (value == null) {
      if (_entity == null) {
        return;
      }
    } else {
      if (_entity == null) {
        // Do nothing
      } else {
        if (_entity.isEqual(value)) {
          return;
        }
      }
    }

    _entity = value;
    _entityChanged.add(_entity);
  }

  @override
  String toString() => '{position: $position, entity: $entity}';

  static List<List<CityTile>> makeTiles(int numCols, int numRows) {
    final ret = List<List<CityTile>>(numRows);

    for (int i = 0; i < ret.length; i++) {
      final row = List<CityTile>(numCols);
      ret[i] = row;

      for (int j = 0; j < row.length; j++) {
        row[j] = CityTile(Position(x: j, y: i));
      }
    }

    return ret;
  }
}

const int maxTileSize = 100;