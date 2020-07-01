import 'dart:async';

import 'package:angular/angular.dart';

@Component(
  selector: 'city-tile',
  styleUrls: ['city_tile_component.css'],
  templateUrl: 'city_tile_component.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class CityTileComponent implements OnInit {
  @Input()
  int id = 0;

  CityTileComponent();

  @override
  Future<Null> ngOnInit() async {
  }

  @HostListener('click')
  void clickHandler(_) {
    print('hello $id');
  }
}
