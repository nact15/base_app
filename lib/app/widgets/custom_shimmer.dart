part of widgets;

class CustomShimmer extends StatefulWidget {
  static CustomShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<CustomShimmerState>();
  }

  final Widget? child;
  final Color baseColor;
  final Color highlightColor;

  const CustomShimmer({
    required this.baseColor,
    required this.highlightColor,
    super.key,
    this.child,
  });

  @override
  CustomShimmerState createState() => CustomShimmerState();
}

class CustomShimmerState extends State<CustomShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(
        min: -0.5,
        max: 1.5,
        period: const Duration(milliseconds: 1000),
      );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  LinearGradient get gradient => LinearGradient(
        colors: [
          widget.highlightColor.withOpacity(0.4),
          widget.highlightColor.withOpacity(0.7),
          widget.highlightColor.withOpacity(0.9),
          widget.highlightColor.withOpacity(0.7),
          widget.highlightColor.withOpacity(0.4),
        ],
        stops: const <double>[
          0,
          0.25,
          0.5,
          0.75,
          1,
        ],
        transform: _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  bool get isSized => (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject()! as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject()! as RenderBox;

    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * slidePercent,
      0.0,
      0.0,
    );
  }
}

class ShimmerLoading extends StatefulWidget {
  final bool isLoading;
  final Widget child;

  const ShimmerLoading({
    required this.isLoading,
    required this.child,
    super.key,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = CustomShimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    final shimmer = CustomShimmer.of(context);
    if (!(shimmer?.isSized ?? false)) {
      return const SizedBox();
    }
    final shimmerSize = shimmer!.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject()! as RenderBox,
    );

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(
          -offsetWithinShimmer.dx,
          -offsetWithinShimmer.dy,
          shimmerSize.width,
          shimmerSize.height,
        ),
      ),
      child: widget.child,
    );
  }
}
