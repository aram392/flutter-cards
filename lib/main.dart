import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flames/cardstable.dart';

void main() async {
  Util flameUtil = Util();
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.util.setPortrait();
    await Flame.util.fullScreen();
  }


  final screenDimensions = await Flame.util.initialDimensions();
  CardsTable game = CardsTable(screenDimensions);
  runApp(game.widget);  
  TapGestureRecognizer tapper = TapGestureRecognizer();
  PanGestureRecognizer panner = PanGestureRecognizer();

  panner.onUpdate = game.onPanUpdate;
  tapper.onTapDown = game.onTapDown;

  flameUtil.addGestureRecognizer(panner);
  flameUtil.addGestureRecognizer(tapper);
}
