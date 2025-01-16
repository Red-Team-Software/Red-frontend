
class DeleteUserDirectionDto {
  final String id;

  DeleteUserDirectionDto({required this.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}