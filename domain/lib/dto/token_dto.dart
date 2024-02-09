part of dto;

@freezed
class OtpStatusDto with _$OtpStatusDto {
  const factory OtpStatusDto({
    required bool status,
    required String message,
    required String code,
  }) = _OtpStatusDto;

  factory OtpStatusDto.fromJson(Map<String, dynamic> json) => _$OtpStatusDtoFromJson(json);
}
