
class AddUserDirectionDto {
  final String name;
  final bool favorite;
  final num lat;
  final num lng;
  AddUserDirectionDto({
    required this.name,
    required this.favorite,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'favorite': favorite,
      'lat': lat,
      'lng': lng,
    };
  }
}

class AddUserDirectionListDto {

  final List<AddUserDirectionDto> directions;

  AddUserDirectionListDto({
    required this.directions,
  });

  Map<String, dynamic> toJson() {
    return {
      'directions': directions.map((e) => e.toJson()).toList(),
    };
  }

}