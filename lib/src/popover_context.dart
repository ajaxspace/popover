import 'package:flutter/material.dart';
import 'package:popover/src/popover_arrow_type.dart';
import 'package:popover/src/popover_direction.dart';
import 'package:popover/src/popover_render_shifted_box.dart';

class PopoverContext extends SingleChildRenderObjectWidget {
  final Rect attachRect;
  final PopoverDirection direction;
  final double arrowWidth;
  final double arrowHeight;
  final Color arrowColor;
  final PopoverArrowType arrowType;

  const PopoverContext({
    required this.attachRect,
    required this.direction,
    required this.arrowWidth,
    required this.arrowHeight,
    required this.arrowColor,
    required this.arrowType,
    Widget? child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return PopoverRenderShiftedBox(
      attachRect: attachRect,
      requestedDirection: direction,
      arrowWidth: arrowWidth,
      arrowHeight: arrowHeight,
      arrowColor: arrowColor,
      arrowType: arrowType,
    );
  }
}
