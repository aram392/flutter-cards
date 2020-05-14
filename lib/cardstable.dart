import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_flames/components/cards.dart';
import 'package:flutter_flames/components/cardplacearea.dart';

enum GameState {
  playing,
  gameOver,
}

class CardsTable extends Game {
  GameState currentGameState = GameState.playing;
  Size viewport;
  Card card;
  CardPlaceableArea placeable;
  double getWidthSize;
  double getHeightSize;
  double spaceSize;
  double cardWidth;
  double numberOfCards;
  List<CardPlaceableArea> safeArea;
  List<Card> handOfCards;

  // Game Score
  CardsTable(screenDimensions) {
    resize(screenDimensions);
    spaceSize=viewport.height/8;
    getWidthSize = viewport.width / 4;
    getHeightSize = viewport.height/3;
    safeArea = List<CardPlaceableArea>();
    handOfCards = List<Card>();
    numberOfCards=6;
    cardWidth=viewport.width/9;

    handOfCards.add(Card(this, viewport.width/numberOfCards+1, viewport.height-cardWidth*1.555,cardWidth,cardWidth*1.555));
    handOfCards.add(Card(this, viewport.width/numberOfCards*2+1, viewport.height-cardWidth*1.555, cardWidth, cardWidth*1.555));
    handOfCards.add(Card(this, viewport.width/numberOfCards*3+1, viewport.height-cardWidth*1.555, cardWidth, cardWidth*1.555));
    handOfCards.add(Card(this, viewport.width/numberOfCards*4+1, viewport.height-cardWidth*1.555, cardWidth, cardWidth*1.555));
    handOfCards.add(Card(this, viewport.width/numberOfCards*5+1, viewport.height-cardWidth*1.555, cardWidth, cardWidth*1.555));


    safeArea.add(CardPlaceableArea(
        this, (getWidthSize * 1)-spaceSize/2, (getHeightSize) * 1.0, spaceSize, spaceSize));
    safeArea.add(CardPlaceableArea(
        this, (getWidthSize * 2)-spaceSize/2, (getHeightSize) * 1.0, spaceSize, spaceSize));
    safeArea.add(CardPlaceableArea(
        this, (getWidthSize * 3)-spaceSize/2, (getHeightSize) * 1.0, spaceSize, spaceSize));
    safeArea.add(CardPlaceableArea(
        this, (getWidthSize * 1)-spaceSize/2, (getHeightSize) * 1.75, spaceSize, spaceSize));
    safeArea.add(CardPlaceableArea(
        this, (getWidthSize * 2)-spaceSize/2, (getHeightSize) * 1.75, spaceSize, spaceSize));
    safeArea.add(CardPlaceableArea(
        this, (getWidthSize * 3)-spaceSize/2, (getHeightSize) * 1.75, spaceSize, spaceSize));
  }
  void render(Canvas c) {
    c.save();
    safeArea.forEach((CardPlaceableArea safe) => safe.render(c));
    handOfCards.forEach((Card card) => card.render(c));
    c.restore();
  }

  void resize(Size size) {
    viewport = size;
  }

  void update(double t) {
    handOfCards.forEach((Card card) => card.update(t));

    if (currentGameState == GameState.playing) {}
  }

  void gameOver() {
    currentGameState = GameState.gameOver;
  }

  void restartGame() {
    currentGameState = GameState.playing;
  }

  void onPanUpdate(DragUpdateDetails d) {
    bool isHandled = false;
    if (!isHandled) {
      handOfCards.forEach((Card card) { 
      if (card.rect.contains(d.globalPosition)) {
        card.onPanUpdate(d);
      }
      });
    }
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;
    if (!isHandled) {
      handOfCards.forEach((Card card) { 
      if (card.rect.contains(d.globalPosition)) {
        card.onTapDown();
      }
      });

    }
  }
}
