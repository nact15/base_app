part of widgets;

class BaseRefreshIndicator extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final ScrollController? scrollController;
  final RefreshController refreshController;

  /// slivers
  final List<Widget> slivers;

  /// в случае, если child Scrollable widget,
  /// то он должен иметь параметры
  ///
  /// [shrinkWrap: true]
  ///
  /// [physics: NeverScrollableScrollPhysics()]
  const BaseRefreshIndicator({
    required this.child,
    required this.onRefresh,
    required this.refreshController,
    super.key,
    this.scrollController,
    this.slivers = const [],
  });

  @override
  State<BaseRefreshIndicator> createState() => _BaseRefreshIndicatorState();
}

class _BaseRefreshIndicatorState extends State<BaseRefreshIndicator> {
  late Completer<void> _refreshCompleter;
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = widget.refreshController;
    _refreshController.addListener(_doneRefresh);
    _refreshCompleter = Completer<void>();
  }

  @override
  void dispose() {
    _refreshController.removeListener(_doneRefresh);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _refreshController = widget.refreshController;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(BaseRefreshIndicator oldWidget) {
    if (oldWidget.refreshController != widget.refreshController) {
      _refreshController = widget.refreshController;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.primary,
      backgroundColor: AppColors.white,
      displacement: 35,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: CustomScrollView(
              controller: widget.scrollController,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                ...widget.slivers,
                SliverToBoxAdapter(child: widget.child),
              ],
            ),
          );
        },
      ),
    );
  }

  void _doneRefresh() {
    if (!_refreshCompleter.isCompleted) {
      setState(() {
        _refreshCompleter.complete();
        _refreshCompleter = Completer<void>();
      });
    }
  }

  Future<void> _onRefresh() async {
    await widget.onRefresh();

    return _refreshCompleter.future;
  }
}

class RefreshController extends ChangeNotifier {
  void doneRefresh() {
    notifyListeners();
  }
}
