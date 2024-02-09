import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  final SplashUseCase _splashUseCase;

  SplashBloc({required SplashUseCase splashUseCase})
      : _splashUseCase = splashUseCase,
        super(SplashState(
          status: BaseStatus.initial,
          splashStatus: SplashStatus.initial,
        )) {
    on<SplashStart>((event, emit) async {
      final isAuth = await _splashUseCase.getIsAuth();
      emit(
        state.copyWith(
          splashStatus: isAuth ? SplashStatus.goToHome : SplashStatus.goToAuthorization,
        ),
      );
    });
  }
}
