import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter_pixel/actors/player.dart';

class Level extends World {
  Level({required this.levelName});
  String levelName;
  late TiledComponent level;
  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16));
    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');
    for (var spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          final player = Player(character: 'Ninja Frog', position: spawnPoint.position);
          add(player);
          break;
        default:
      }
    }
    return super.onLoad();
  }
}
