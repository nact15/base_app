part of 'widgets.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final Widget? title;
  final double elevation;
  final double leadingWidth;
  final EdgeInsets? titlePadding;

  const BaseAppBar({
    required this.automaticallyImplyLeading,
    required this.centerTitle,
    super.key,
    this.title,
    this.elevation = 0,
    this.leadingWidth = 24,
    this.titlePadding,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: omit_local_variable_types
    final BaseUrl baseUrl = injection();

    return AppBar(
      title: Padding(
        padding: titlePadding ?? EdgeInsets.only(left: automaticallyImplyLeading ? 12 : 16),
        child: title,
      ),
      titleTextStyle: context.theme.appBarTheme.titleTextStyle?.copyWith(height: 1.2),
      titleSpacing: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      leadingWidth: baseUrl == BaseUrl.dev ? kLeadingWidth + 72 : kLeadingWidth,
      leading: automaticallyImplyLeading
          ? Row(
              children: [
                const SizedBox(width: 16),
                SizedBox(
                  width: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    visualDensity: VisualDensity.compact,
                    icon: BaseIcon(
                      icon: AppIcons.leading,
                      size: 24,
                      color: context.theme.appBarTheme.iconTheme?.color,
                    ),
                    onPressed: context.pop,
                  ),
                ),
                if (baseUrl == BaseUrl.dev)
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => _pushToTalkerScreen(context),
                  ),
              ],
            )
          : (baseUrl == BaseUrl.dev)
              ? IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => _pushToTalkerScreen(context),
                )
              : null,
    );
  }

  void _pushToTalkerScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Theme(
        data: AppTheme.mainTheme,
        child: TalkerScreen(talker: injection()),
      ),
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
