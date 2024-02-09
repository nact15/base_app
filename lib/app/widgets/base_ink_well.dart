part of widgets;

class BaseInkWell extends StatelessWidget {
  final void Function()? onTap;
  final double radius;
  final Widget child;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Color? color;
  final Color? shadowColor;
  final double elevation;
  final bool enabledFeedback;

  BaseInkWell({
    required this.onTap,
    required this.child,
    super.key,
    this.radius = 50,
    this.borderRadius,
    this.padding,
    this.color,
    this.shadowColor,
    this.elevation = 0.0,
    this.enabledFeedback = true,
  });

  DateTime? _loginClickTime;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.transparent,
      shadowColor: shadowColor,
      elevation: elevation,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: InkWell(
        onTap: () async {
          await Future.delayed(const Duration(milliseconds: 100));
          if (_isRedundantClick(DateTime.now())) {
            return;
          }
          onTap?.call();
        },
        radius: radius,
        highlightColor: Colors.transparent,
        splashFactory: InkRipple.splashFactory,
        splashColor: enabledFeedback ? Colors.cyan.withOpacity(0.12) : Colors.transparent,
        borderRadius: borderRadius,
        child: Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }

  bool _isRedundantClick(DateTime currentTime) {
    if (_loginClickTime == null) {
      _loginClickTime = currentTime;

      return false;
    }
    if (currentTime.difference(_loginClickTime!).inMilliseconds < 1000) {
      return true;
    }

    _loginClickTime = currentTime;

    return false;
  }
}
