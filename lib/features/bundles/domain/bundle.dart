import 'package:equatable/equatable.dart';

class Bundle extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> imageUrl;
  final double price;
  final String currency;
  final int? weigth;
  final String? measurement;

  Bundle(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.price,
      required this.currency,
      this.weigth,
      this.measurement});

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        price,
        currency,
        weigth,
        measurement
      ];
}
