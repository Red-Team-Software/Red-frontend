import 'package:GoDeli/features/wallet/application/dto/add_funds_pago_movil_dto.dart';
import 'package:GoDeli/features/wallet/application/use_cases/pay_pago_movil_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final PayPagoMovilUseCase payPagoMovilUseCase;

  WalletBloc({
    required this.payPagoMovilUseCase,
  }) : super(NotPaying()) {
    on<PayPagoMovil>(_onPayPagoMovil);
  }

  void _onPayPagoMovil(PayPagoMovil event, Emitter<WalletState> emit) async {
    emit(Paying());

    final res = await payPagoMovilUseCase.execute(AddFundsPagoMovilDto(
        amount: event.amount,
        phone: event.phone,
        reference: event.reference,
        bank: event.bank,
        identification: event.identification,
        paymentId: event.paymentId));

    if (!res.isSuccessful()) {
      emit(PayingError(res.getError().toString()));
      return;
    }

    emit(NotPaying());
  }
}
