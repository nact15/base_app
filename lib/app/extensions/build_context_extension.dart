part of extensions;

extension BuildContextExtension<T> on BuildContext {
  ThemeData get theme => Theme.of(this);

  Size get screenSize => MediaQuery.of(this).size;

  void popUntil(
    bool Function(Route<dynamic> route) predicate,
  ) =>
      router.popUntil(predicate);

  void unfocus() => FocusScope.of(this).unfocus();

  void requestFocus([FocusNode? node]) => FocusScope.of(this).requestFocus(node);

  void nextFocus() => FocusScope.of(this).nextFocus();

  void pushNamedAndRemoveUntil(String path) => Navigator.of(this).pushNamedAndRemoveUntil(
        path,
        (_) => false,
      );

  Future<T?> push<T>(PageRouteInfo route) => router.push<T>(route);

  Future<void> replace(PageRouteInfo route) => router.replace(route);

  void replaceAll(List<PageRouteInfo> routes) => router.replaceAll(routes);

  void popAndPush(PageRouteInfo route) => router.popAndPush(route);

  void pop<T>([T? result]) => router.pop(result);

  bool canPop() => router.canPop();

  void forcePop<T>([T? result]) => router.popForced(result);

  void navigate(PageRouteInfo route) => router.navigate(route);

  double widthByPercent(double percent) {
    assert(percent >= 0 && percent <= 100);

    return (screenSize.width * percent) / 100;
  }

  double heightByPercent(double percent) {
    assert(percent >= 0 && percent <= 100);

    return (screenSize.height * percent) / 100;
  }
}
