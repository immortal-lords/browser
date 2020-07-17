import 'dart:async';

import 'package:common/common.dart';
import 'package:common/view.dart';

class BattleFieldTile {
  final Position position;

  final Position globalPosition;

  BattleFieldEntity _entity;

  final _entityChanged = StreamController<BattleFieldEntity>();

  Stream<BattleFieldEntity> _entityChangedStream;

  BattleFieldTile(this.position)
      : globalPosition =
            Position(x: position.x, y: position.y + numRowsInCity) {
    _entityChangedStream = _entityChanged.stream.asBroadcastStream();
  }

  BattleFieldEntity get entity => _entity;

  Stream<BattleFieldEntity> get onEntityChange => _entityChangedStream;

  set entity(BattleFieldEntity value) {
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

  static List<List<BattleFieldTile>> makeTiles(int numCols, int numRows) {
    final ret = List<List<BattleFieldTile>>(numRows);

    for (int i = 0; i < ret.length; i++) {
      final row = List<BattleFieldTile>(numCols);
      ret[i] = row;

      for (int j = 0; j < row.length; j++) {
        row[j] = BattleFieldTile(Position(x: j, y: i));
      }
    }

    return ret;
  }
}

const int maxTileSize = 100;
