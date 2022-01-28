import 'package:cobra_escada/cobras_escadas.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasGameRef<CobrasEscadas> {
  Color pColor;
  late Paint paint;

  Player({required this.pColor});

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    paint = Paint()..color = pColor;
    canvas.drawRect(size.toRect(), paint);
  }

  void move(Vector2 delta) {
    double duracao = 1;
    if (delta.x > 263 || delta.x < -263) {
      duracao = 2;
    }
    add(MoveEffect.by(delta, EffectController(duration: duracao)));
    Timer(3000);
  }
}