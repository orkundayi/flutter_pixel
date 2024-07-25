import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pixel/actors/player.dart';
import 'package:flutter_pixel/levels/level.dart';

class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  bool showJoystick = true;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    final world = Level(player: player, levelName: 'Level-01');
    cam = CameraComponent.withFixedResolution(world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll(<Component>[cam, world]);
    if (showJoystick) {
      await addJoystick();
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick) _updateJoyStick(dt);
    super.update(dt);
  }

  Future<void> addJoystick() async {
    joystick = JoystickComponent(
      margin: const EdgeInsets.only(left: 32, bottom: 32),
      knob: SpriteComponent(
        sprite: Sprite(
          await images.load('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          await images.load('HUD/Joystick.png'),
        ),
      ),
    );
    cam.viewport.add(joystick);
  }

  void _updateJoyStick(double dt) {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.playerDirection = PlayerDirection.right;
        break;
      default:
        player.playerDirection = PlayerDirection.none;
        break;
    }
  }
}
