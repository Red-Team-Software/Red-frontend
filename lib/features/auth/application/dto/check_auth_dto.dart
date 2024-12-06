
class CheckAuthDto {
  final String token;

  CheckAuthDto({required this.token});

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}