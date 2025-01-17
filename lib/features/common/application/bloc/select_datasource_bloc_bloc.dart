import 'package:GoDeli/config/constants/enviroments.dart';
import 'package:GoDeli/presentation/core/theme/theme.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

part 'select_datasource_bloc_event.dart';
part 'select_datasource_bloc_state.dart';

class SelectDatasourceBloc extends Bloc<SelectDatasourceEvent, SelectDatasourceState> {
  SelectDatasourceBloc() : super(const SelectDatasourceState()) {
    on<SelectDatasource>(_onSelectDatasource);
  }

  void _onSelectDatasource(SelectDatasource event, Emitter<SelectDatasourceState> emit) {

    emit(state.copyWith(isRed: event.isRed));
    print('Stripe key: ${Environment.getStripePublishableKey()}');
    Stripe.publishableKey = Environment.getStripePublishableKey();

  }
}
