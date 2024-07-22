import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter_pixel/pixel_adventure.dart';

enum PlayerState { idle, running, jumping, doubleJumping, falling }

class Player extends SpriteAnimationGroupComponent with HasGameRef<PixelAdventure> {
  Player({super.position, required this.character});

  String character;

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;

  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation(
      animationName: 'Idle',
      amount: 11,
    );
    runningAnimation = _spriteAnimation(
      animationName: 'Run',
      amount: 12,
    );

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
    };

    current = PlayerState.running;
  }

  _spriteAnimation({required String animationName, required int amount}) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$animationName (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
