part of dto;

@freezed
class UserLoginDto with _$UserLoginDto {
  const factory UserLoginDto({
    required String password,
    required String username,
  }) = _UserLoginDto;

  factory UserLoginDto.fromJson(Map<String, dynamic> json) => _$UserLoginDtoFromJson(json);
}
