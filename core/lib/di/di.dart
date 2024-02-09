part of core;

GetIt injection = GetIt.I;

enum BaseUrl {
  dev,
  prod;

  factory BaseUrl.fromString(String url) {
    if (url.contains('dev')) {
      return BaseUrl.dev;
    }

    return BaseUrl.prod;
  }
}

const secureStorage = FlutterSecureStorage();

class AppDependencies {
  static final AppDependencies instance = AppDependencies._();

  factory AppDependencies() => instance;

  AppDependencies._();

  Future<void> setDependencies() async {
    await dotenv.load();

    final baseUrl = dotenv.env['BASE_URL'] ?? CoreConstants.baseUrl;

    final url = BaseUrl.fromString(baseUrl);

    injection.registerLazySingleton<BaseUrl>(() => url);

    ///-------------------------------------------------------------
    /// network - dio
    /// ------------------------------------------------------------

    final dio = Dio(
      BaseOptions(
        baseUrl: '${CoreConstants.https}$baseUrl${CoreConstants.apiV1}',
        contentType: CoreConstants.contentTypeJson,
      ),
    );
    final authDio = Dio(
      BaseOptions(
        baseUrl: '${CoreConstants.https}$baseUrl${CoreConstants.apiV1}',
        contentType: CoreConstants.contentTypeXWWWUrlEncoded,
      ),
    );
    final weatherDio = Dio(
      BaseOptions(
        contentType: CoreConstants.contentTypeJson,
      ),
    );

    _initTalker(
      baseUrl,
      authDio: authDio,
      dio: dio,
      weatherDio: weatherDio,
    );

    ///-------------------------------------------------------------
    /// local database
    /// ------------------------------------------------------------

    // TODO: lj,fdbnm sh
    // final dir = await getApplicationDocumentsDirectory();
    // final isar = await Isar.open(
    //   [EntitySchema],
    //   directory: dir.path,
    // );

    if (Platform.isAndroid) SharedPreferencesAndroid.registerWith();
    if (Platform.isIOS) SharedPreferencesIOS.registerWith();
    final sharedPreferences = await SharedPreferences.getInstance();

    ///-------------------------------------------------------------
    /// dependencies
    /// -------------------------------------------------------------
    injection
      ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
      ..registerLazySingleton<FlutterSecureStorage>(() => secureStorage)

      ///-------------------------------------------------------------
      /// repositories
      /// -------------------------------------------------------------
      ..registerLazySingleton<TokenRepository>(
        () => TokenRepositoryImpl(secureStorage: injection()),
      )

      ///-------------------------------------------------------------
      /// use cases
      /// -------------------------------------------------------------
      ..registerLazySingleton<SplashUseCase>(
        () => SplashUseCase(
          tokenRepository: injection(),
        ),
      );

    ///-------------------------------------------------------------
    /// interceptors
    /// -------------------------------------------------------------
    authDio.interceptors.add(AppInterceptor());
    weatherDio.interceptors.add(AppInterceptor());

    dio.interceptors.add(
      TokenInterceptor(secureStorageRepository: injection()),
    );
  }
}

void _initTalker(
  String baseUrl, {
  required Dio authDio,
  required Dio dio,
  required Dio weatherDio,
}) {
  final talker = TalkerFlutter.init(
    settings: TalkerSettings(
      maxHistoryItems: 100,
    ),
    logger: TalkerLogger(),
  );

  injection.registerLazySingleton<Talker>(() => talker);

  final dioLogger = TalkerDioLogger(
    talker: injection(),
    settings: const TalkerDioLoggerSettings(
      printRequestHeaders: true,
      printResponseHeaders: true,
    ),
  );

  authDio.interceptors.add(dioLogger);

  dio.interceptors.add(dioLogger);

  weatherDio.interceptors.add(dioLogger);
}
