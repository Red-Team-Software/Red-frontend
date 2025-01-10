

class UpdateUserDto {
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? image;

  UpdateUserDto({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.image,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (password != null) data['password'] = password;
    if (image != null) data['image'] = image;
    return data;
  }
}