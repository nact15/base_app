part of dto;

@freezed
class UserReadDto with _$UserReadDto {
  const factory UserReadDto({
    required int id,
    required String email,
    @JsonKey(name: 'is_active')
    required bool isActive,
    @JsonKey(name: 'is_superuser')
    required bool isSuperuser,
    @JsonKey(name: 'is_verified')
    required bool isVerified,
    required String username,
    @JsonKey(name: 'phone_number')
    required String phoneNumber,
  }) = _UserReadDto;

  factory UserReadDto.fromJson(Map<String, dynamic> json) => _$UserReadDtoFromJson(json);
}
