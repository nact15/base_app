// ignore_for_file: invalid_annotation_target

part of dto;

@freezed
class ProfileCreateDto with _$ProfileCreateDto {
  const factory ProfileCreateDto({
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'contact_phone') required String contactPhone,
    @JsonKey(name: 'residential_address') String? residentialAddress,
    @JsonKey(includeIfNull: false) String? photo,
    @JsonKey(includeIfNull: false, name: 'identity_proof') String? identityProof,
    @JsonKey(includeIfNull: false) String? nik,
    @JsonKey(includeIfNull: false, name: 'nik_photo') String? nikPhoto,
    @JsonKey(includeIfNull: false, name: 'contact_email') String? contactEmail,
    @JsonKey(name: 'registered_address') required String registeredAddress,
    @JsonKey(includeIfNull: false) bool? archived,
    required Language language,
    @JsonKey(includeIfNull: false) bool? verified,
    @JsonKey(includeIfNull: false, name: 'verify_comment') String? verifyComment,
  }) = _ProfileCreateDto;

  factory ProfileCreateDto.fromJson(Map<String, dynamic> json) => _$ProfileCreateDtoFromJson(json);
}
