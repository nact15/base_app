part of core;

abstract class BaseBloc<E, S extends BaseState> extends Bloc<E, S>
    with InternetConnectionMixin
    implements ErrorHandler<S> {
  BaseBloc(super.initialState);

  EventTransformer<E> eventTransformer() => sequential<E>();

  @override
  BaseError handleError(
    Object error,
    StackTrace stackTrace,
    Emitter<BaseState> emit, {
    bool onlyLog = false,
  }) {
    AppLogger.logError(
      message: 'Error in BLoC $runtimeType',
      error: error,
      stackTrace: stackTrace,
    );

    if (!onlyLog) {
      emit(state.copyWith(
        status: BaseStatus.error,
        baseError: getError(error),
      ));
    }

    return getError(error);
  }

  BaseError getError(Object error) {
    if (error is BaseError) {
      return error;
    } else if (error is NoInternetConnection) {
      return BaseError(ErrorType.noInternetConnection);
    } else if (error is Unauthorized) {
      return BaseError(ErrorType.unauthorized);
    } else if (error is NotFound) {
      return BaseError(ErrorType.notFound, message: error.message);
    } else if (error is ServerUnavailable) {
      return BaseError(ErrorType.serverUnavailable, message: error.message);
    } else if (error is ServerTemporarilyUnavailable) {
      return BaseError(ErrorType.serverUnavailable);
    } else if (error is TooManyRequests) {
      return BaseError(ErrorType.tooManyRequests);
    } else if (error is NotAcceptable) {
      return BaseError(ErrorType.notAcceptable, message: error.message);
    } else if (error is UnprocessableEntity) {
      return BaseError(ErrorType.unprocessableEntity);
    } else if (error is Conflict) {
      return BaseError(ErrorType.conflict);
    } else if (error is BadRequest) {
      return BaseError(ErrorType.badRequest, message: error.message);
    } else if (error is Forbidden) {
      return BaseError(ErrorType.forbidden);
    } else {
      return BaseError(ErrorType.unknown);
    }
  }
}

abstract class ErrorHandler<S extends BaseState> {
  void handleError(Object error, StackTrace stackTrace, Emitter<S> emit);
}

// mixin IsolateWrapper<E, S extends BaseState> on BaseBloc<E, S> {
//   FutureOr<T> backgroundFetch<T>({
//     required Future<T> Function(T) task,
//     required T arguments,
//   }) async {
//     return await backgroundFetchArgs(task: task, arguments: arguments);
//   }
// }

enum BaseStatus { initial, loading, error, success }

extension BaseStatusExtension on BaseStatus {
  bool get isSuccess => this == BaseStatus.success;

  bool get isLoading => this == BaseStatus.loading;

  bool get isInitial => this == BaseStatus.initial;

  bool get isError => this == BaseStatus.error;
}

abstract interface class StateCopyWith {
  BaseState copyWith({required BaseStatus status, BaseError? baseError});
}

abstract class BaseState implements StateCopyWith {
  final BaseStatus status;
  final BaseError? baseError;

  const BaseState({required this.status, this.baseError});

  bool get error => status.isError;

  bool get loading => status.isLoading;

  bool get success => status.isSuccess;

  bool get initial => status.isInitial;
}

class BaseError {
  final ErrorType errorType;
  final String? message;

  BaseError(this.errorType, {this.message});

  factory BaseError.fromString(String error) {
    return switch (error) {
      'noInternetConnection' => BaseError(ErrorType.noInternetConnection),
      'unauthorized' => BaseError(ErrorType.unauthorized),
      'notFound' => BaseError(ErrorType.notFound),
      'serverUnavailable' => BaseError(ErrorType.serverUnavailable),
      'tooManyRequests' => BaseError(ErrorType.tooManyRequests),
      'conflict' => BaseError(ErrorType.conflict),
      'badRequest' => BaseError(ErrorType.badRequest),
      'unprocessableEntity' => BaseError(ErrorType.unprocessableEntity),
      'notAcceptable' => BaseError(ErrorType.notAcceptable),
      _ => BaseError(ErrorType.unknown),
    };
  }

  factory BaseError.fromError(Object error) {
    if (error is NoInternetConnection) {
      return BaseError(ErrorType.noInternetConnection);
    } else if (error is Unauthorized) {
      return BaseError(ErrorType.unauthorized);
    } else if (error is NotFound) {
      return BaseError(ErrorType.notFound, message: error.message);
    } else if (error is ServerUnavailable) {
      return BaseError(ErrorType.serverUnavailable, message: error.message);
    } else if (error is ServerTemporarilyUnavailable) {
      return BaseError(ErrorType.serverUnavailable);
    } else if (error is TooManyRequests) {
      return BaseError(ErrorType.tooManyRequests);
    } else if (error is NotAcceptable) {
      return BaseError(ErrorType.notAcceptable, message: error.message);
    } else if (error is UnprocessableEntity) {
      return BaseError(ErrorType.unprocessableEntity);
    } else if (error is Conflict) {
      return BaseError(ErrorType.conflict);
    } else if (error is BadRequest) {
      return BaseError(ErrorType.badRequest);
    } else {
      return BaseError(ErrorType.unknown);
    }
  }

  @override
  String toString() => errorType.name;
}

enum ErrorType {
  noInternetConnection,
  unauthorized,
  notFound,
  serverUnavailable,
  tooManyRequests,
  conflict,
  badRequest,
  unprocessableEntity,
  notAcceptable,
  forbidden,
  unknown,
}

extension BaseErrorExtension on BaseError? {
  bool get isNoInternetConnection => this?.errorType == ErrorType.noInternetConnection;

  bool get isUnauthorized => this?.errorType == ErrorType.unauthorized;

  bool get isNotFound => this?.errorType == ErrorType.notFound;

  bool get isServerUnavailable => this?.errorType == ErrorType.serverUnavailable;

  bool get isTooManyRequests => this?.errorType == ErrorType.tooManyRequests;

  bool get isBadRequest => this?.errorType == ErrorType.badRequest;

  bool get isUnprocessableEntity => this?.errorType == ErrorType.unprocessableEntity;

  bool get isConflict => this?.errorType == ErrorType.conflict;

  bool get isUnknown => this?.errorType == ErrorType.unknown;
}

mixin InternetConnectionMixin {
  StreamSubscription<bool>? _internetSubscription;

  Future<bool> checkConnection(void Function() fallback) async {
    var hasConnection = false;
    if (!(await InternetConnectionHelper().hasConnection())) {
      _internetSubscription = InternetConnectionHelper().hasInternetConnection.listen(
        (hasInternetConnection) {
          if (hasInternetConnection) {
            fallback();
            hasConnection = true;
          }
        },
      );
    } else {
      await _internetSubscription?.cancel();
      hasConnection = true;
    }

    return hasConnection;
  }
}
