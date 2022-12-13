extension DoubleExt on double {
  double? get finiteOrNull => isFinite ? this : null;
}
