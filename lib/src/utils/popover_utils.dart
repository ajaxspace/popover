import 'dart:math';

import 'package:flutter/material.dart';
import 'package:popover/src/popover_direction.dart';
import 'package:popover/src/utils/utils.dart';

const _kScreenPadding = 16;

mixin PopoverUtils {
  static PopoverDirection popoverDirection(
    Rect attachRect,
    Size size,
    PopoverDirection? direction,
    double? arrowHeight,
  ) {
    switch (direction) {
      case PopoverDirection.top:
        {
          if (attachRect.top > size.height + arrowHeight!) {
            return PopoverDirection.top;
          }

          final availableHeight = Utils().screenHeight;

          if (attachRect.top >= availableHeight - attachRect.bottom) {
            return PopoverDirection.top;
          } else {
            return PopoverDirection.bottom;
          }
        }
      case PopoverDirection.bottom:
        {
          final availableHeight = Utils().screenHeight;

          if (availableHeight > attachRect.bottom + size.height + arrowHeight!) {
            return PopoverDirection.bottom;
          }

          if (attachRect.top > availableHeight - attachRect.bottom) {
            return PopoverDirection.top;
          } else {
            return PopoverDirection.bottom;
          }
        }

      case PopoverDirection.left:
        {
          if (attachRect.left > size.width + arrowHeight!) {
            return PopoverDirection.left;
          }

          final availableWidth = Utils().screenWidth;

          if (attachRect.left >= availableWidth - attachRect.right) {
            return PopoverDirection.left;
          } else {
            return PopoverDirection.right;
          }
        }

      case PopoverDirection.right:
        {
          final availableWidth = Utils().screenWidth;

          if (availableWidth > attachRect.right + size.width + arrowHeight!) {
            return PopoverDirection.right;
          }

          if (attachRect.left > availableWidth - attachRect.right) {
            return PopoverDirection.left;
          } else {
            return PopoverDirection.right;
          }
        }

      default:
        return PopoverDirection.bottom;
    }
  }

  static BoxConstraints getEnforcedConstraints({
    required Rect attachRect,
    required double arrowHeight,
    required BoxConstraints initialConstraints,
    required PopoverDirection requestedDirection,
  }) {
    final BoxConstraints sizeConstraints;

    final availableHeight = Utils().screenHeight;
    final availableWidth = Utils().screenWidth;

    if (requestedDirection.isVertical) {
      final biggestAvailableSpace =
          max(attachRect.top, availableHeight - attachRect.bottom) - arrowHeight - _kScreenPadding;

      sizeConstraints = initialConstraints.copyWith(
        minWidth: min(initialConstraints.minWidth, availableWidth - _kScreenPadding * 2),
        maxWidth: min(initialConstraints.maxWidth, availableWidth - _kScreenPadding * 2),
        minHeight: min(initialConstraints.minHeight, biggestAvailableSpace - 16),
        maxHeight: min(initialConstraints.maxHeight, biggestAvailableSpace),
      );
    } else {
      final biggestAvailableSpace =
          max(attachRect.left, availableWidth - attachRect.right) - arrowHeight - _kScreenPadding;

      sizeConstraints = initialConstraints.copyWith(
        minHeight: min(initialConstraints.minWidth, availableHeight - _kScreenPadding * 2),
        maxHeight: min(initialConstraints.maxHeight, availableHeight - _kScreenPadding * 2),
        minWidth: min(initialConstraints.minWidth, biggestAvailableSpace - 16),
        maxWidth: min(initialConstraints.maxWidth, biggestAvailableSpace),
      );
    }

    return sizeConstraints;
  }
}
