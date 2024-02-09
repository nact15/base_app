// ignore_for_file: invalid_annotation_target

part of dto;

@freezed
class ProfileResponseDto with _$ProfileResponseDto {
  const factory ProfileResponseDto({
    @JsonKey(includeToJson: false) required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'contact_phone') required String contactPhone,
    @JsonKey(name: 'residential_address') required String? residentialAddress,
    @JsonKey(includeIfNull: false) String? photo,
    @JsonKey(includeIfNull: false, name: 'identity_proof') String? identityProof,
    @JsonKey(includeIfNull: false) String? nik,
    @JsonKey(includeIfNull: false, name: 'nik_photo') String? nikPhoto,
    @JsonKey(includeIfNull: false, name: 'contact_email') String? contactEmail,
    @JsonKey(includeIfNull: false, name: 'registered_address') String? registeredAddress,
    required Language language,
    required bool verified,
    @JsonKey(includeIfNull: false, name: 'verify_comment') String? verifyComment,
  }) = _ProfileResponseDto;

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseDtoFromJson(json);
}
