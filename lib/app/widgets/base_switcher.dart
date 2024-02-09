part of widgets;

enum SwitcherProps {
  padding,
  color,
  backgroundColor,
}

class BaseSwitcher extends StatefulWidget {
  final Function(bool enabled) callBack;
  final bool initValue;
  final EdgeInsets? padding;
  final String? text;
  final MainAxisSize mainAxisSize;

  const BaseSwitcher({
    required this.callBack,
    Key? key,
    this.initValue = false,
    this.padding,
    this.text,
    this.mainAxisSize = MainAxisSize.min,
  }) : super(key: key);

  @override
  State<BaseSwitcher> createState() => _BaseSwitcherState();
}

class _BaseSwitcherState extends State<BaseSwitcher> {
  late bool checked;

  @override
  void initState() {
    checked = widget.initValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BaseSwitcher oldWidget) {
    checked = widget.initValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    const indicatorSize = 22.0;
    const buttonWidth = 52.0;
    const buttonHeight = 32.0;

    return Row(
      mainAxisSize: widget.mainAxisSize,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              checked = !checked;
            });
            widget.callBack.call(checked);
          },
          behavior: HitTestBehavior.translucent,
          child: _CustomSwitchButton(
            checked: checked,
            indicatorSize: indicatorSize,
            unBackgroundColor: AppColors.white,
            backgroundColor: AppColors.primary,
            animationDuration: const Duration(milliseconds: 350),
            unCheckedColor: AppColors.white,
            checkedColor: AppColors.white,
            buttonWidth: buttonWidth,
            buttonHeight: buttonHeight,
            backgroundBorderRadius: 100,
            paddingOut: 4,
          ),
        ),
        if (widget.text != null)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                widget.text!,
              ),
            ),
          ),
      ],
    );
  }
}

class _CustomSwitchButton extends StatefulWidget {
  final bool checked;

  final Color checkedColor;
  final Color unCheckedColor;

  final Duration animationDuration;

  final Color backgroundColor;
  final Color unBackgroundColor;

  final double buttonWidth;

  final double buttonHeight;
  final double indicatorSize;
  final double backgroundBorderRadius;

  // отступ от круга
  final double paddingOut;

  const _CustomSwitchButton({
    required this.backgroundColor,
    required this.unBackgroundColor,
    required this.checked,
    required this.checkedColor,
    required this.unCheckedColor,
    required this.animationDuration,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.indicatorSize,
    required this.backgroundBorderRadius,
    required this.paddingOut,
    super.key,
  });

  @override
  State<_CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<_CustomSwitchButton> with AnimationMixin {
  late Tween padding;
  late MovieTween _tween;

  late ColorTween _color;
  late ColorTween _backgroundColor;

  @override
  void initState() {
    _createTweens();
    _tween = _createTween();
    super.initState();
  }

  @override
  void didUpdateWidget(_CustomSwitchButton oldWidget) {
    if (widget.checkedColor != oldWidget.checkedColor) {
      _createTweens();
      _tween = _createTween();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final control = widget.checked ? Control.play : Control.playReverse;

    return CustomAnimationBuilder<Movie>(
      control: control,
      curve: Curves.easeInOut,
      tween: _tween,
      duration: _tween.duration,
      builder: (context, value, child) {
        return Container(
          width: widget.buttonWidth,
          height: widget.buttonHeight,
          decoration: _outerBoxDecoration(
            value.get(SwitcherProps.backgroundColor),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Transform.translate(
              offset: Offset(value.get(SwitcherProps.padding), 0),
              child: Container(
                decoration: _innerBoxDecoration(value.get(SwitcherProps.color)),
                width: widget.indicatorSize,
                height: widget.indicatorSize,
              ),
            ),
          ),
        );
      },
    );
  }

  void _createTweens() {
    padding = Tween(
      begin: widget.paddingOut,
      end: widget.buttonWidth - widget.indicatorSize - widget.paddingOut,
    );
    _color = ColorTween(
      begin: widget.unCheckedColor,
      end: widget.checkedColor,
    );
    _backgroundColor = ColorTween(
      begin: widget.unBackgroundColor,
      end: widget.backgroundColor,
    );
  }

  MovieTween _createTween() => MovieTween()
    ..scene(begin: Duration.zero, duration: widget.animationDuration)
        .tween(SwitcherProps.padding, padding)
        .tween(SwitcherProps.color, _color)
        .tween(SwitcherProps.backgroundColor, _backgroundColor)
    ..scene(begin: Duration.zero, duration: widget.animationDuration)
        .tween(SwitcherProps.padding, padding)
        .tween(SwitcherProps.color, _color)
        .tween(SwitcherProps.backgroundColor, _backgroundColor);

  BoxDecoration _innerBoxDecoration(Color color) => BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      );

  BoxDecoration _outerBoxDecoration(Color color) => BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.backgroundBorderRadius),
        ),
        color: color,
      );
}
