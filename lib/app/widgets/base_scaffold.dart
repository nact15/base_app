part of widgets;

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final bool topSafe;
  final bool bottomSafe;
  final bool extendBody;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final Widget? bottomSheet;
  final bool extendBodyBehindAppBar;
  final bool buildAppBar;

  const BaseScaffold({
    required this.body,
    super.key,
    this.topSafe = true,
    this.bottomSafe = true,
    this.extendBody = false,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.appBar,
    this.bottomSheet,
    this.extendBodyBehindAppBar = false,
    this.buildAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GestureDetector(
        onTap: context.unfocus,
        child: SafeArea(
          top: topSafe,
          bottom: bottomSafe,
          child: Scaffold(
            body: body,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            bottomSheet: bottomSheet,
            backgroundColor: backgroundColor,
            extendBody: extendBody,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            floatingActionButton: floatingActionButton,
            bottomNavigationBar: bottomNavigationBar,
            appBar: buildAppBar ? appBar : null,
          ),
        ),
      ),
    );
  }
}
