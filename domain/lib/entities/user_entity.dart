part of entities;

@Collection()
class UserEntity {
  UserEntity();

  Id? id;
  late String email;
  late bool isActive;
  late bool isSuperuser;
  late bool isVerified;
  late String username;
  late String phoneNumber;

  factory UserEntity.fromDto(UserReadDto dto) {
    return UserEntity()
      ..id = dto.id
      ..email = dto.email
      ..isActive = dto.isActive
      ..isSuperuser = dto.isSuperuser
      ..isVerified = dto.isVerified
      ..username = dto.username
      ..phoneNumber = dto.phoneNumber;
  }
}
