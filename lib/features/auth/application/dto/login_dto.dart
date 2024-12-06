class LoginDto {
  final String email;
  final String password;

  LoginDto(this.email, this.password);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}