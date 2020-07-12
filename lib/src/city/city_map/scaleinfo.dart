import 'package:common/common.dart';

class ScaleInfo {
  final int id;

  final num scale;

  final int actualTileWidth;

  final int actualTileHeight;

  final int tileWidth;

  final int tileHeight;

  final int landWidth;

  final int landHeight;

  static int base = 100;

  ScaleInfo({this.id, this.scale})
      : tileWidth = convertX(base * scale),
        tileHeight = convertY(base * scale),
        actualTileWidth = base * scale,
        actualTileHeight = base * scale,
        landWidth = convertX(base * 15 * scale),
        landHeight = convertY(base * 15 * scale);

  int convertPosX(Position pos) =>
      ((pos.y - pos.x - 1) * (tileWidth / 2)).toInt() /* + (landWidth ~/ 2)*/;

  int convertPosY(Position pos) => ((pos.x + pos.y) * (tileHeight / 2)).toInt();

  static int convertX(int x) => x ~/ 0.70711356243;

  static int convertY(int y) => y ~/ (0.70711356243 * 1.74342537804);

  static final scales = <ScaleInfo>[
    ScaleInfo(id: 0, scale: 0.25),
    ScaleInfo(id: 1, scale: 0.5),
    ScaleInfo(id: 2, scale: 0.75),
    ScaleInfo(id: 3, scale: 1)
  ];
}

/*
x1 = ((y - x - 1) * width/2) + totalWidth/2
y1 = (x + y) * height/2
 */

/*
x1 = (x + y - 2) * width/2
y1 = (x - y - 1) * height/2
 */
