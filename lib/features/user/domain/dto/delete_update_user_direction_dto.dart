
class DeleteUpdateUserDirectionDto {
  final String id;
  final String name;
  final bool favorite;
  final num lat;
  final num lng;
  DeleteUpdateUserDirectionDto({
    required this.id,
    required this.name,
    required this.favorite,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'favorite': favorite,
      'lat': lat,
      'lng': lng,
    };
  }
}

class DeleteUpdateUserDirectionListDto {

  final List<DeleteUpdateUserDirectionDto> directions;

  DeleteUpdateUserDirectionListDto({
    required this.directions,
  });

  Map<String, dynamic> toJson() {
    return {
      'directions': directions.map((e) => e.toJson()).toList(),
    };
  }

}