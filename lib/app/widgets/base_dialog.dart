part of widgets;

class BaseDialog<T> {
  BaseDialog._();

  static _AppDialog? _current;

  static final GlobalKey _flushBarKey = GlobalKey();

  static Future<T?> showBaseDialog<T>(
    BuildContext context, {
    required String title,
    String? content,
    bool barrierDismissible = true,
    bool useRootNavigator = true,
    EdgeInsets? insetPadding,
    bool scrollable = false,
    ActionsBuilder<T>? actionsBuilder,
    EdgeInsets? actionsPadding,
    Future<bool> Function()? onWillPop,
    MainAxisAlignment? actionsAlignment,
    Widget? customTitle,
  }) async {
    if (_current != null) return null;

    _current = _BaseDialog<T>(
      title: title,
      content: content,
      customTitle: customTitle,
      barrierDismissible: barrierDismissible,
      insetPadding: insetPadding,
      onWillPop: onWillPop,
      actionsAlignment: actionsAlignment,
      actionsBuilder: actionsBuilder,
      actionsPadding: actionsPadding,
      scrollable: scrollable,
      setCurrent: _setCurrent,
    );
    if (_current != null) {
      return showDialog<T>(
        context: context,
        barrierColor: Colors.black.withOpacity(0.32),
        useRootNavigator: useRootNavigator,
        barrierDismissible: barrierDismissible,
        useSafeArea: false,
        builder: (_) => _current ?? const SizedBox(),
      );
    }

    return null;
  }

  static void dispose<T>([T? result]) {
    if (_current != null) {
      if (result != null) {
        _current!.dismiss(result);
      } else {
        _current!.dismiss();
      }
    }
    _setCurrent();
  }

  static void closeSnackBar() {
    (_flushBarKey.currentWidget as Flushbar?)?.dismiss();
  }

  static Future<dynamic> showErrorDialog<T>(
    BuildContext context, {
    String? errorTitle,
    String? errorText,
    ActionsBuilder<T>? actions,
    EdgeInsets? actionsPadding,
    MainAxisAlignment? actionsAlignment,
  }) async {
    return showBaseDialog(
      context,
      title: errorTitle ?? '',
      actionsAlignment: actionsAlignment,
      content: errorText,
      actionsPadding: actionsPadding,
      actionsBuilder: actions != null
          ? (context, dismiss) => actions(context, dismiss)
          : (_, dismiss) => <Widget>[
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: BaseTextButton(
                //     expanded: false,
                //     onPressed: dismiss,
                //     fontWeight: FontWeight.w500,
                //     text: context.localizations.ok,
                //   ),
                // ),
              ],
    );
  }

  static void _setCurrent() {
    _current = null;
  }
}

mixin _AppDialogService<T> {
  void dismiss([T? result]);
}

abstract class _AppDialog<T> extends StatelessWidget with _AppDialogService<T> {
  const _AppDialog({super.key});
}

typedef ActionsBuilder<T> = List<Widget> Function(BuildContext, Function([T?]));

class _BaseDialog<T> extends _AppDialog<T> {
  final String title;
  final String? content;
  final EdgeInsets? insetPadding;
  final bool scrollable;
  final ActionsBuilder<T>? actionsBuilder;
  final EdgeInsets? actionsPadding;
  final Future<bool> Function()? onWillPop;
  final bool barrierDismissible;
  final Function() setCurrent;
  final MainAxisAlignment actionsAlignment;
  final Widget? customTitle;
  final String? contentImageSvg;

  _BaseDialog({
    required this.title,
    required this.content,
    required this.insetPadding,
    required this.scrollable,
    required this.actionsBuilder,
    required this.actionsPadding,
    required this.onWillPop,
    required this.barrierDismissible,
    required this.setCurrent,
    this.contentImageSvg,
    super.key,
    MainAxisAlignment? actionsAlignment,
    this.customTitle,
  }) : actionsAlignment = actionsAlignment ?? MainAxisAlignment.end;

  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return WillPopScope(
      onWillPop: () {
        if (onWillPop != null) {
          onWillPop?.call();
        }
        if (barrierDismissible) dismiss();

        return Future.value(false);
      },
      child: AlertDialog(
        title: customTitle ?? Text(title),
        titlePadding: const EdgeInsets.only(top: 20, left: 24, right: 24),
        contentPadding: const EdgeInsets.only(top: 12, left: 24, right: 24),
        content: content != null
            ? Column(
                children: [
                  Text(content!),
                  if (contentImageSvg != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: BaseIcon(icon: contentImageSvg!),
                    ),
                ],
              )
            : null,
        actions: ((actionsBuilder?.call(context, dismiss).length ?? 0) > 1)
            ? [
                Row(
                  mainAxisAlignment: actionsAlignment,
                  children: actionsBuilder!.call(context, dismiss),
                ),
              ]
            : actionsBuilder?.call(context, dismiss),
        actionsPadding: actionsPadding ??
            const EdgeInsets.only(
              top: 26,
              left: 24,
              right: 24,
              bottom: 26,
            ),
        actionsAlignment: MainAxisAlignment.end,
        buttonPadding: EdgeInsets.zero,
        elevation: 5,
        shadowColor: context.theme.shadowColor.withOpacity(0.2),
        scrollable: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        insetPadding: insetPadding ?? const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: AppColors.white,
      ),
    );
  }

  @override
  void dismiss([T? result]) {
    if (_context?.canPop() ?? false) _context?.forcePop(result);
    setCurrent();
  }
}
