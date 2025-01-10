import 'package:GoDeli/features/payment-method/application/use_cases/get_payment_methods_use_case.dart';
import 'package:GoDeli/features/payment-method/domain/payment-method.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  final GetPaymentMethodsUseCase getPaymentMethodsUseCase;
  
  PaymentMethodBloc(
    {required this.getPaymentMethodsUseCase}
  ) : super(PaymentMethodState()) {
    on<LoadPaymentMethodEvent>(_onLoadPaymentMethodEvent);
    add(LoadPaymentMethodEvent());
  }

  _onLoadPaymentMethodEvent(LoadPaymentMethodEvent event, emit) async {
    emit(PaymentMethodLoading());
    final result = await getPaymentMethodsUseCase.execute(null);

    if (result.isSuccessful()) {
      emit(PaymentMethodLoaded(result.getValue()));
    } else {
      emit(PaymentMethodError('Error loading payment methods'));
    }
  }

  _addFundsPagoMovil(AddFundsPagoMovil event, emit) async {
    emit(Paying());
    
  }
}
