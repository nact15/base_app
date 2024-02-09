// ignore_for_file: invalid_annotation_target
part of dto;

@freezed
class UserCreateDto with _$UserCreateDto {
  const factory UserCreateDto({
    @JsonKey(includeIfNull: false) required String? email,
    required String password,
    @JsonKey(includeIfNull: false) required String? username,
    @JsonKey(name: 'phone_number') required String phoneNumber,
  }) = _UserCreateDto;

  factory UserCreateDto.fromJson(Map<String, dynamic> json) => _$UserCreateDtoFromJson(json);
}
