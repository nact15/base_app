part of core;

class InternetConnectionHelper {
  static final InternetConnectionHelper instance = InternetConnectionHelper._();

  factory InternetConnectionHelper() => instance;

  InternetConnectionHelper._() {
    initSubscription();
  }

  Future<bool> hasConnection() async =>
      await Connectivity().checkConnectivity().then((value) => value != ConnectivityResult.none);

  final StreamController<bool> _internetController = StreamController.broadcast();

  Stream<bool> get hasInternetConnection => _internetController.stream;

  Future<void> initSubscription() async {
    final hasConnectionState = await hasConnection();

    _internetController.add(hasConnectionState);

    Connectivity().onConnectivityChanged.listen(
      (event) {
        _internetController.add(event != ConnectivityResult.none);
      },
    );
  }
}
