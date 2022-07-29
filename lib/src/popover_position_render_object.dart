import 'package:flutter/rendering.dart';

import 'popover_direction.dart';
import 'popover_render_shifted_box.dart';
import 'utils/popover_utils.dart';
import 'utils/utils.dart';

class PopoverPositionRenderObject extends RenderShiftedBox {
  final Rect attachRect;
  final PopoverDirection direction;
  final BoxConstraints additionalConstraints;
  final double arrowHeight;
  final ValueChanged<Offset> arrowOffsetNotifier;

  PopoverPositionRenderObject({
    required this.arrowHeight,
    required this.additionalConstraints,
    required this.attachRect,
    required this.direction,
    required this.arrowOffsetNotifier,
    RenderBox? child,
  }) : super(child);

  Offset calculateOffset(Size size) {
    final _direction = PopoverUtils.popoverDirection(
      attachRect,
      size,
      direction,
      arrowHeight,
    );

    if (_direction.isVertical) {
      return _dxOffset(_direction, _horizontalOffset(size), size);
    } else {
      return _dyOffset(_direction, _verticalOffset(size), size);
    }
  }

  @override
  void performLayout() {
    final localChild = child!;

    localChild.layout(
      additionalConstraints.enforce(constraints),
      parentUsesSize: true,
    );

    size = Size(constraints.maxWidth, constraints.maxHeight);
    final childParentData = localChild.parentData as BoxParentData?;
    final localOffset = calculateOffset(localChild.size);
    childParentData?.offset = localOffset;

    if (localChild is PopoverRenderShiftedBox) {
      arrowOffsetNotifier(
        localChild
            .getArrowOffset(localOffset, localChild.size)
            .translate(localOffset.dx, localOffset.dy),
      );
    }
  }

  Offset _dxOffset(
    PopoverDirection direction,
    double horizontalOffset,
    Size size,
  ) {
    if (direction == PopoverDirection.bottom) {
      return Offset(horizontalOffset, attachRect.bottom);
    } else {
      return Offset(horizontalOffset, attachRect.top - size.height);
    }
  }

  Offset _dyOffset(
    PopoverDirection _direction,
    double verticalOffset,
    Size size,
  ) {
    if (_direction == PopoverDirection.right) {
      return Offset(attachRect.right, verticalOffset);
    } else {
      return Offset(attachRect.left - size.width, verticalOffset);
    }
  }

  double _horizontalOffset(Size size) {
    var offset = 0.0;

    if (attachRect.left > size.width / 2 &&
        Utils().screenWidth - attachRect.right > size.width / 2) {
      offset = attachRect.left + attachRect.width / 2 - size.width / 2;
    } else if (attachRect.left < size.width / 2) {
      offset = arrowHeight;
    } else {
      offset = Utils().screenWidth - arrowHeight - size.width;
    }
    return offset;
  }

  double _verticalOffset(Size size) {
    var offset = 0.0;

    if (attachRect.top > size.height / 2 &&
        Utils().screenHeight - attachRect.bottom > size.height / 2) {
      offset = attachRect.top + attachRect.height / 2 - size.height / 2;
    } else if (attachRect.top < size.height / 2) {
      offset = arrowHeight;
    } else {
      offset = Utils().screenHeight - arrowHeight - size.height;
    }
    return offset;
  }
}
