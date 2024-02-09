part of 'splash_bloc.dart';

class SplashState extends BaseState {
  final SplashStatus splashStatus;

  SplashState({
    required super.status,
    required this.splashStatus,
    super.baseError,
  });

  @override
  SplashState copyWith({
    BaseStatus? status,
    BaseError? baseError,
    SplashStatus? splashStatus,
  }) {
    return SplashState(
      status: status ?? this.status,
      baseError: baseError,
      splashStatus: splashStatus ?? this.splashStatus,
    );
  }
}

enum SplashStatus {
  initial,
  goToHome,
  goToAuthorization,
}
