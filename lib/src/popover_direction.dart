/// Popover direction
enum PopoverDirection {
  top,
  bottom,
  left,
  right,
}

extension Direction on PopoverDirection {
  bool get isHorizontal {
    switch (this) {
      case PopoverDirection.left:
      case PopoverDirection.right:
        return true;
      default:
        return false;
    }
  }

  bool get isVertical {
    switch (this) {
      case PopoverDirection.top:
      case PopoverDirection.bottom:
        return true;
      default:
        return false;
    }
  }
}
