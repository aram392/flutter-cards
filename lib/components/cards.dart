import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/rendering.dart';

import 'package:flame/gestures.dart';
import 'package:flutter_flames/cardstable.dart';
import 'package:flutter_flames/components/core/gameobject.dart';

class Card extends GameObject with PanDetector {
  Paint paint;
  double x;
  double y;
  double height;
  double width;
  Rect rect;
  bool hit;


  Card(CardsTable game, this.x, this.y, this.height, this.width):super(game) {
  paint=Paint();
  paint.color=Colors.yellow;
  rect = Rect.fromLTWH(this.x, this.y, this.height, this.width);
  hit=false;
  }

  void onTapDown() {
    hit=true;
  }

  
  void onPanUpdate(DragUpdateDetails details) {
    rect = rect.translate(details.delta.dx, details.delta.dy);
  }

  @override
  void update(double dt) {
    if (hit==true){
      paint.color=Colors.red;
    }
  }

  @override
  void render(Canvas c) {
    c.drawRect(rect, paint);
  }
}