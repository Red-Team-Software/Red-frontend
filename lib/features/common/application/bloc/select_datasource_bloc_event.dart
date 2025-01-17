part of 'select_datasource_bloc_bloc.dart';

sealed class SelectDatasourceEvent  {
  const SelectDatasourceEvent();
}

class SelectDatasource extends SelectDatasourceEvent {

  final bool isRed;

  const SelectDatasource({required this.isRed});

}