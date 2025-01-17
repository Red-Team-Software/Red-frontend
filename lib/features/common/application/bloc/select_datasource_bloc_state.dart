part of 'select_datasource_bloc_bloc.dart';

class SelectDatasourceState extends Equatable {
  final bool isRed;
  const SelectDatasourceState(
      {this.isRed = true});

  SelectDatasourceState copyWith(
          {bool? isRed}) =>
      SelectDatasourceState(
        isRed: isRed ?? this.isRed,
      );

  @override
  List<Object> get props => [isRed];
}

