import 'package:flutter/painting.dart';
import 'package:popover/src/popover_arrow_type.dart';
import 'package:popover/src/popover_direction.dart';

class PopoverPath {
  const PopoverPath();

  Path draw(
    PopoverDirection direction,
    Rect arrowRect,
    PopoverArrowType arrowType,
  ) {
    final path = Path();

    if (direction == PopoverDirection.top) {
      _drawTopElement(path, arrowRect, arrowType);
    } else if (direction == PopoverDirection.right) {
      _drawRightElement(path, arrowRect, arrowType);
    } else if (direction == PopoverDirection.left) {
      _drawLeftElement(path, arrowRect, arrowType);
    } else {
      _drawBottomElement(path, arrowRect, arrowType);
    }

    path.close();

    return path;
  }

  void _drawBottomElement(
    Path path,
    Rect arrowRect,
    PopoverArrowType arrowType,
  ) {
    path.moveTo(arrowRect.left, arrowRect.bottom);

    if (arrowType == PopoverArrowType.sharp) {
      path.lineTo(arrowRect.left + arrowRect.width / 2, arrowRect.top);
      path.lineTo(arrowRect.right, arrowRect.bottom);
    } else {
      path.cubicTo(
        arrowRect.left + arrowRect.width / 2,
        arrowRect.top - arrowRect.height / 4,
        arrowRect.left + arrowRect.width / 2,
        arrowRect.top - arrowRect.height / 4,
        arrowRect.right,
        arrowRect.bottom,
      );
    }
  }

  void _drawLeftElement(
    Path path,
    Rect arrowRect,
    PopoverArrowType arrowType,
  ) {
    path.moveTo(arrowRect.left, arrowRect.top);

    if (arrowType == PopoverArrowType.sharp) {
      path.lineTo(arrowRect.right, arrowRect.top + arrowRect.height / 2);
      path.lineTo(arrowRect.left, arrowRect.bottom);
    } else {
      path.cubicTo(
        arrowRect.right + arrowRect.width / 4,
        arrowRect.top + arrowRect.height / 2,
        arrowRect.right + arrowRect.width / 4,
        arrowRect.top + arrowRect.height / 2,
        arrowRect.left,
        arrowRect.bottom,
      );
    }
  }

  void _drawRightElement(
    Path path,
    Rect arrowRect,
    PopoverArrowType arrowType,
  ) {
    path.moveTo(arrowRect.right, arrowRect.top);

    if (arrowType == PopoverArrowType.sharp) {
      path.lineTo(arrowRect.left, arrowRect.top + arrowRect.height / 2);
      path.lineTo(arrowRect.right, arrowRect.bottom);
    } else {
      path.cubicTo(
        arrowRect.left - arrowRect.width / 4,
        arrowRect.top + arrowRect.height / 2,
        arrowRect.left - arrowRect.width / 4,
        arrowRect.top + arrowRect.height / 2,
        arrowRect.right,
        arrowRect.bottom,
      );
    }
  }

  void _drawTopElement(
    Path path,
    Rect arrowRect,
    PopoverArrowType arrowType,
  ) {
    path.moveTo(arrowRect.left, arrowRect.top);

    if (arrowType == PopoverArrowType.sharp) {
      path.lineTo(arrowRect.left + arrowRect.width / 2, arrowRect.bottom);
      path.lineTo(arrowRect.right, arrowRect.top);
    } else {
      path.cubicTo(
        arrowRect.left + arrowRect.width / 2,
        arrowRect.bottom + arrowRect.height / 4,
        arrowRect.left + arrowRect.width / 2,
        arrowRect.bottom + arrowRect.height / 4,
        arrowRect.right,
        arrowRect.top,
      );
    }
  }
}
