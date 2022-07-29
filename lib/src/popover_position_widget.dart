import 'package:flutter/material.dart';

import 'popover_direction.dart';
import 'popover_position_render_object.dart';

class PopoverPositionWidget extends SingleChildRenderObjectWidget {
  final Rect attachRect;
  final BoxConstraints constraints;
  final PopoverDirection direction;
  final double arrowHeight;
  final ValueChanged<Offset> arrowOffsetNotifier;

  const PopoverPositionWidget({
    required this.arrowHeight,
    required this.attachRect,
    required this.direction,
    required this.constraints,
    required this.arrowOffsetNotifier,
    Widget? child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return PopoverPositionRenderObject(
      attachRect: attachRect,
      direction: direction,
      additionalConstraints: constraints,
      arrowHeight: arrowHeight,
      arrowOffsetNotifier: arrowOffsetNotifier,
    );
  }
}
