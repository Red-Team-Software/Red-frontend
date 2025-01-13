import 'package:equatable/equatable.dart';

class TaxShipping extends Equatable {
  final double taxes;
  final double shipping;

  const TaxShipping({
    required this.taxes,
    required this.shipping,
  });

  @override
  List<Object?> get props => [taxes, shipping];
}
