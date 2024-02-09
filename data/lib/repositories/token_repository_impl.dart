part of repositories;

class TokenRepositoryImpl implements TokenRepository {
  final FlutterSecureStorage _secureStorage;

  TokenRepositoryImpl({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

  final String tokenType = 'token_type';
  final String accessToken = 'access_token';

  @override
  Future<String?> getAccessToken() async {
    return _secureStorage.read(key: accessToken);
  }

  @override
  Future<String?> getTokenType() async {
    return _secureStorage.read(key: tokenType);
  }

  @override
  Future<void> saveToken(TokenDto token) async {
    await _secureStorage.write(key: accessToken, value: token.accessToken);

    await _secureStorage.write(key: tokenType, value: token.tokenType);
  }

  @override
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: accessToken);

    await _secureStorage.delete(key: tokenType);
  }

  @override
  Future<TokenDto?> getToken() async {
    final accessToken = await getAccessToken();

    final tokenType = await getTokenType();

    if (tokenType != null && accessToken != null) {
      return TokenDto(accessToken: accessToken, tokenType: tokenType);
    }

    return null;
  }
}
