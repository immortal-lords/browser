import 'dart:async';

import 'package:angular/angular.dart';

import 'city_tile.dart';

@Component(
  selector: 'city-tile',
  styleUrls: ['city_tile_component.css'],
  templateUrl: 'city_tile_component.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class CityTileComponent implements OnInit, AfterChanges {
  @Input()
  CityTile tile;

  @Input()
  num scale = 1;

  CityTileComponent();

  @override
  void ngAfterChanges() {
    print(tile);
  }

  @override
  Future<Null> ngOnInit() async {
  }

  @HostListener('click')
  void clickHandler() {
    print(tile.position);
  }

  @HostBinding('style.width.px')
  int get width => (100 * scale).toInt();

  @HostBinding('style.height.px')
  int get height => (100 * scale).toInt();
}
