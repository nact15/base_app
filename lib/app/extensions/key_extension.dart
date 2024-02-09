part of extensions;

extension KeyExtension on GlobalKey {
  Offset? get offset {
    final box = currentContext?.findRenderObject() as RenderBox?;

    return box?.localToGlobal(Offset.zero);
  }

  Size? get size {
    final box = currentContext?.findRenderObject() as RenderBox?;

    return box?.size;
  }

  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);

      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}
