

import 'package:GoDeli/features/user/domain/user_direction.dart';

class GetUserDirectionsResponse {
  final List<UserDirection> directions;

  GetUserDirectionsResponse({required this.directions});

  factory GetUserDirectionsResponse.fromJson(List<dynamic> json) {
    return GetUserDirectionsResponse(
      directions: UserDirection.fromJsonList(json),
    );
  }
}