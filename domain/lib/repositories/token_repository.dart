part of repositories;

abstract interface class TokenRepository {
  Future<String?> getAccessToken();

  Future<TokenDto?> getToken();

  Future<void> saveToken(TokenDto token);

  Future<void> deleteToken();

  Future<String?> getTokenType();
}
