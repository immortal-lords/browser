class ScaleInfo {
  final int id;

  final num value;

  final int marginLeft;

  final int marginTop;

  final int landWidth;

  final int landHeight;

  const ScaleInfo(
      {this.id,
        this.value,
        this.marginLeft,
        this.marginTop,
        this.landWidth,
        this.landHeight});

  static const scales = <ScaleInfo>[
    ScaleInfo(
        id: 0,
        value: 0.25,
        marginLeft: 77,
        marginTop: -34,
        landWidth: 530,
        landHeight: 304),
    ScaleInfo(
        id: 1,
        value: 0.5,
        marginLeft: 156,
        marginTop: -70,
        landWidth: 1060,
        landHeight: 608),
    ScaleInfo(
        id: 2,
        value: 0.75,
        marginLeft: 232,
        marginTop: -105,
        landWidth: 1590,
        landHeight: 912),
    ScaleInfo(
        id: 3,
        value: 1,
        marginLeft: 310,
        marginTop: -141,
        landWidth: 2121,
        landHeight: 1216)
  ];
}