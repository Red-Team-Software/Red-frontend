

abstract class IUpdateUserDto {
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? image;

  IUpdateUserDto({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.image,
  });
}