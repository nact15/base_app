part of entities;

@Collection()
class ProfileEntity {
  ProfileEntity();

  late Id id;
  late int userId;
  String? photo;
  String? identityProof;
  late String fullName;
  String? nik;
  String? nikPhoto;
  late String contactPhone;
  String? contactEmail;
  String? residentialAddress;
  String? registeredAddress;
  late bool verified;
  String? verifyComment;
  @enumerated
  late Language language;

  factory ProfileEntity.fromDto(ProfileResponseDto dto) {
    return ProfileEntity()
      ..id = dto.id
      ..language = dto.language
      ..fullName = dto.fullName
      ..verified = dto.verified
      ..verifyComment = dto.verifyComment
      ..contactEmail = dto.contactEmail
      ..residentialAddress = dto.residentialAddress
      ..contactPhone = dto.contactPhone
      ..nik = dto.nik
      ..nikPhoto = dto.nikPhoto
      ..photo = dto.photo
      ..identityProof = dto.identityProof
      ..userId = dto.userId;
  }

  ProfileResponseDto toDto() {
    return ProfileResponseDto(
      id: id ?? 0,
      language: language,
      contactPhone: contactPhone,
      fullName: fullName,
      userId: userId,
      residentialAddress: residentialAddress,
      verified: verified,
      verifyComment: verifyComment,
      identityProof: identityProof,
      nik: nik,
      nikPhoto: nikPhoto,
      photo: photo,
      registeredAddress: residentialAddress,
      contactEmail: contactEmail,
    );
  }
}
