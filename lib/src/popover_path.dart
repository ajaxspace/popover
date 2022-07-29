import 'package:flutter/painting.dart';

import 'popover_direction.dart';

class PopoverPath {
  const PopoverPath();

  Path draw(
    PopoverDirection direction,
    Rect arrowRect,
  ) {
    final path = Path();

    if (direction == PopoverDirection.top) {
      _drawTopElement(path, arrowRect);
    } else if (direction == PopoverDirection.right) {
      _drawRightElement(path, arrowRect);
    } else if (direction == PopoverDirection.left) {
      _drawLeftElement(path, arrowRect);
    } else {
      _drawBottomElement(path, arrowRect);
    }
    path.close();

    return path;
  }

  void _drawBottomElement(Path path, Rect arrowRect) {
    path.moveTo(arrowRect.left, arrowRect.bottom);
    path.lineTo(arrowRect.left + arrowRect.width / 2, arrowRect.top);
    path.lineTo(arrowRect.right, arrowRect.bottom);
  }

  void _drawLeftElement(Path path, Rect arrowRect) {
    path.moveTo(arrowRect.left, arrowRect.top);
    path.lineTo(arrowRect.right, arrowRect.top + arrowRect.height / 2);
    path.lineTo(arrowRect.left, arrowRect.bottom);
  }

  void _drawRightElement(Path path, Rect arrowRect) {
    path.moveTo(arrowRect.right, arrowRect.top);
    path.lineTo(arrowRect.left, arrowRect.top + arrowRect.height / 2);
    path.lineTo(arrowRect.right, arrowRect.bottom);
  }

  void _drawTopElement(Path path, Rect arrowRect) {
    path.moveTo(arrowRect.left, arrowRect.top);
    path.lineTo(arrowRect.left + arrowRect.width / 2, arrowRect.bottom);
    path.lineTo(arrowRect.right, arrowRect.top);
  }
}
