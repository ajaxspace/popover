import 'package:flutter/material.dart';

import 'popover_context.dart';
import 'popover_direction.dart';
import 'popover_position_widget.dart';
import 'utils/utils.dart';

class PopoverItem extends StatefulWidget {
  final Widget child;
  final PopoverDirection direction;
  final double arrowWidth;
  final double arrowHeight;
  final BoxConstraints? constraints;
  final BuildContext context;
  final double arrowDxOffset;
  final double arrowDyOffset;
  final double contentDyOffset;
  final Color arrowColor;
  final bool Function()? isParentAlive;
  final ValueChanged<Offset> arrowOffsetNotifier;
  final Rect attachRect;

  const PopoverItem({
    required this.child,
    required this.context,
    required this.direction,
    required this.attachRect,
    required this.arrowColor,
    required this.arrowWidth,
    required this.arrowHeight,
    required this.arrowDxOffset,
    required this.arrowDyOffset,
    required this.contentDyOffset,
    required this.arrowOffsetNotifier,
    this.constraints,
    this.isParentAlive,
    Key? key,
  }) : super(key: key);

  @override
  _PopoverItemState createState() => _PopoverItemState();
}

class _PopoverItemState extends State<PopoverItem> {
  late BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    _configure();

    return Stack(
      children: [
        PopoverPositionWidget(
          attachRect: widget.attachRect,
          constraints: constraints,
          direction: widget.direction,
          arrowHeight: widget.arrowHeight,
          arrowOffsetNotifier: widget.arrowOffsetNotifier,
          child: PopoverContext(
            attachRect: widget.attachRect,
            direction: widget.direction,
            arrowWidth: widget.arrowWidth,
            arrowHeight: widget.arrowHeight,
            arrowColor: widget.arrowColor,
            child: widget.child,
          ),
        )
      ],
    );
  }

  void _configure() {
    final isParentAlive = widget.isParentAlive?.call() ?? true;

    if (!isParentAlive) {
      return;
    }

    final box = widget.context.findRenderObject() as RenderBox?;

    if (mounted && box?.owner != null) {
      _configureConstraints();
    }
  }

  void _configureConstraints() {
    BoxConstraints _constraints;
    final localConstraints = widget.constraints;

    if (localConstraints != null) {
      _constraints = BoxConstraints(
        maxHeight: Utils().screenHeight / 2,
        maxWidth: Utils().screenHeight / 2,
      ).copyWith(
        minWidth: localConstraints.minWidth.isFinite ? localConstraints.minWidth : null,
        minHeight: localConstraints.minHeight.isFinite ? localConstraints.minHeight : null,
        maxWidth: localConstraints.maxWidth.isFinite ? localConstraints.maxWidth : null,
        maxHeight: localConstraints.maxHeight.isFinite ? localConstraints.maxHeight : null,
      );
    } else {
      _constraints = BoxConstraints(
        maxHeight: Utils().screenHeight / 2,
        maxWidth: Utils().screenHeight / 2,
      );
    }
    if (widget.direction.isVertical) {
      constraints = _constraints.copyWith(
        maxHeight: _constraints.maxHeight + widget.arrowHeight,
        maxWidth: _constraints.maxWidth,
      );
    } else {
      constraints = _constraints.copyWith(
        maxHeight: _constraints.maxHeight + widget.arrowHeight,
        maxWidth: _constraints.maxWidth + widget.arrowWidth,
      );
    }
  }
}
