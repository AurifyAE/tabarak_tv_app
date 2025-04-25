import 'package:flutter/material.dart';

enum PriceChangeState {
  neutral,

  increase,

  decrease,
}

extension PriceChangeStateExtension on PriceChangeState {
  Color get color {
    switch (this) {
      case PriceChangeState.increase:
        return Colors.greenAccent;
      case PriceChangeState.decrease:
        return Colors.redAccent;
      case PriceChangeState.neutral:
        return Colors.white;
    }
  }

  bool get isChanged => this != PriceChangeState.neutral;
}
