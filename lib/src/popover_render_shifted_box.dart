import 'package:flutter/rendering.dart';
import 'package:popover/src/popover_arrow_type.dart';
import 'package:popover/src/popover_direction.dart';
import 'package:popover/src/popover_path.dart';
import 'package:popover/src/utils/popover_utils.dart';

class PopoverRenderShiftedBox extends RenderShiftedBox {
  final double arrowWidth;
  final double arrowHeight;
  final Color arrowColor;
  final PopoverArrowType arrowType;
  PopoverDirection requestedDirection;
  PopoverDirection? _resolvedDirection;
  Rect? _resolvedArrowRect;
  Rect attachRect;

  PopoverRenderShiftedBox({
    required this.arrowWidth,
    required this.arrowHeight,
    required this.attachRect,
    required this.requestedDirection,
    required this.arrowColor,
    required this.arrowType,
    RenderBox? child,
  }) : super(child);

  @override
  void paint(PaintingContext context, Offset offset) {
    final localChild = child!;

    final transform = Matrix4.identity();

    final _direction = _resolvedDirection ??
        (_resolvedDirection = PopoverUtils.popoverDirection(
          attachRect,
          size,
          requestedDirection,
          arrowHeight,
        ));

    final arrowRect = _resolvedArrowRect ??
        (_resolvedArrowRect = _getArrowRect(
          _direction,
          attachRect.left + attachRect.width / 2 - arrowWidth / 2 - offset.dx,
          localChild.size,
          attachRect.top + attachRect.height / 2 - arrowWidth / 2 - offset.dy,
        ));

    final childParentData = localChild.parentData as BoxParentData;

    _pushClipPath(
      context,
      offset,
      const PopoverPath().draw(_direction, arrowRect, arrowType),
      transform,
    );

    localChild.paint(
      context,
      offset.translate(childParentData.offset.dx, childParentData.offset.dy),
    );
  }

  Rect _getArrowRect(
    PopoverDirection _direction,
    double arrowLeft,
    Size size,
    double arrowTop,
  ) {
    switch (_direction) {
      case PopoverDirection.top:
        return Rect.fromLTWH(arrowLeft, size.height, arrowWidth, arrowHeight);
      case PopoverDirection.bottom:
        return Rect.fromLTWH(arrowLeft, 0, arrowWidth, arrowHeight);
      case PopoverDirection.left:
        return Rect.fromLTWH(size.width, arrowTop, arrowHeight, arrowWidth);
      case PopoverDirection.right:
        return Rect.fromLTWH(0, arrowTop, arrowHeight, arrowWidth);
    }
  }

  Offset getArrowOffset(Offset offset, Size childSize) {
    final arrowLeft = attachRect.left + attachRect.width / 2 - arrowWidth / 2 - offset.dx;
    final arrowTop = attachRect.top + attachRect.height / 2 - arrowWidth / 2 - offset.dy;

    final realSize = Size(
      childSize.width - (requestedDirection.isHorizontal ? arrowHeight : 0),
      childSize.height - (requestedDirection.isVertical ? arrowHeight : 0),
    );

    final localDirection = _resolvedDirection ??
        (_resolvedDirection = PopoverUtils.popoverDirection(
          attachRect,
          childSize,
          requestedDirection,
          arrowHeight,
        ));

    final arrowRect = _resolvedArrowRect = _getArrowRect(
      localDirection,
      arrowLeft,
      realSize,
      arrowTop,
    );

    switch (localDirection) {
      case PopoverDirection.top:
        return arrowRect.bottomCenter;
      case PopoverDirection.bottom:
        return arrowRect.topCenter;
      case PopoverDirection.left:
        return arrowRect.centerRight;
      case PopoverDirection.right:
        return arrowRect.centerLeft;
    }
  }

  void _pushClipPath(
    PaintingContext context,
    Offset offset,
    Path path,
    Matrix4 transform,
  ) {
    context.pushClipPath(needsCompositing, offset, offset & size, path, (
      context,
      offset,
    ) {
      final backgroundPaint = Paint();
      backgroundPaint.color = arrowColor;
      context.canvas.drawPath(path.shift(offset), backgroundPaint);

      super.paint(context, offset);
    });
  }

  @override
  void performLayout() {
    assert(constraints.maxHeight.isFinite);

    final constrains = _configureChildConstrains();

    _configureChildSize(child!.size, constrains);

    _configureChildOffset();
  }

  BoxConstraints _configureChildConstrains() {
    child?.layout(
      constraints,
      parentUsesSize: true,
    );

    return constraints;
  }

  void _configureChildSize(Size childSize, BoxConstraints constraints) {
    size = Size(
      constraints.constrainWidth(childSize.width),
      constraints.constrainHeight(childSize.height),
    );
  }

  void _configureChildOffset() {
    final _direction = _resolvedDirection = PopoverUtils.popoverDirection(
      attachRect,
      size,
      requestedDirection,
      arrowHeight,
    );

    final childParentData = child?.parentData as BoxParentData?;

    if (childParentData == null) {
      return;
    }

    if (_direction == PopoverDirection.bottom) {
      childParentData.offset = Offset(0, arrowHeight);
    } else if (_direction == PopoverDirection.right) {
      childParentData.offset = Offset(arrowHeight, 0);
    } else if (_direction == PopoverDirection.left) {
      childParentData.offset = Offset(-arrowHeight, 0);
    } else {
      childParentData.offset = Offset(0, -arrowHeight);
    }
  }
}
