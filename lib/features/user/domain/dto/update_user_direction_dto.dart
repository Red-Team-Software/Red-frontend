
class UpdateUserDirectionDto {
  final String id;
  final String name;
  final bool favorite;
  final num lat;
  final num lng;
  final String direction;
  UpdateUserDirectionDto({
    required this.id,
    required this.name,
    required this.favorite,
    required this.lat,
    required this.lng,
    required this.direction,
  });

  //TODO: Implement ToString en lat y long
  Map<String, dynamic> toJson() {
    return {
      'directionId': id,
      'name': name,
      'direction': direction,
      'favorite': favorite,
      'lat': lat,
      'long': lng,
    };
  }
}

class UpdateUserDirectionListDto {

  final List<UpdateUserDirectionDto> directions;

  UpdateUserDirectionListDto({
    required this.directions,
  });

  Map<String, dynamic> toJson() {
    return {
      'directions': directions.map((e) => e.toJson()).toList(),
    };
  }

}