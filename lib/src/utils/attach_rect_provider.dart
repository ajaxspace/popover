import 'package:flutter/cupertino.dart';
import 'package:popover/src/utils/build_context_extension.dart';

class AttachRectProvider {
  const AttachRectProvider();

  Rect getAttachRect(
    BuildContext context, {
    required double arrowDxOffset,
    required double arrowDyOffset,
    required double contentDyOffset,
  }) {
    final offset = BuildContextExtension.getWidgetLocalToGlobal(context);
    final bounds = BuildContextExtension.getWidgetBounds(context);
    final attachRect = Rect.fromLTWH(
      offset.dx + arrowDxOffset,
      offset.dy + arrowDyOffset,
      bounds.width,
      bounds.height + contentDyOffset,
    );

    return attachRect;
  }
}
