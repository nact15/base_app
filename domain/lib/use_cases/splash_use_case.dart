part of use_cases;

class SplashUseCase {
  final TokenRepository _tokenRepository;

  SplashUseCase({
    required TokenRepository tokenRepository,
  })  : _tokenRepository = tokenRepository;

  Future<bool> getIsAuth() async {
    final isAuth = await _tokenRepository.getToken().then((value) => value != null);

    return isAuth;
  }
}
