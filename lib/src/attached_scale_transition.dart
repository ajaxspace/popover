import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class AttachedScaleTransition extends AnimatedWidget {
  final Offset attachRect;
  final Widget? child;

  Animation<double> get scale => listenable as Animation<double>;

  AttachedScaleTransition({
    required Animation<double> scale,
    required this.attachRect,
    required this.child,
  }) : super(listenable: scale);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      alignment: null,
      scale: scale.value,
      origin: attachRect,
      child: child,
    );
  }
}
