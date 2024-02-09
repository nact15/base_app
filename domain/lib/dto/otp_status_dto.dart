// ignore_for_file: invalid_annotation_target
part of dto;

@freezed
class TokenDto with _$TokenDto {
  const factory TokenDto({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'token_type') required String tokenType,
  }) = _TokenDto;

  factory TokenDto.fromJson(Map<String, dynamic> json) => _$TokenDtoFromJson(json);
}
