import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/checkout/aplication/checkout/checkout_bloc.dart';
import 'package:GoDeli/features/checkout/aplication/checkout/checkout_event.dart';
import 'package:GoDeli/features/checkout/aplication/checkout/checkout_state.dart';
import 'package:GoDeli/features/order/domain/repositories/order_repository.dart';
import 'package:GoDeli/features/payment-method/domain/repositories/payment-method_repository.dart';
import 'package:GoDeli/features/tax-shipping/domain/repositories/tax-shipping_repository.dart';
import 'package:GoDeli/features/user/application/use_cases/add_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/delete_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/get_user_directions_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/update_user_direction_use_case.dart';
import 'package:GoDeli/presentation/widgets/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/shipping_address_section.dart';
import 'widgets/delivery_time_section.dart';
import 'widgets/payment_method_section.dart';
import 'widgets/order_summary_section.dart';
import 'package:GoDeli/features/cart/application/bloc/cart_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  static const String name = 'checkout_screen';

  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutBloc(
        cartBloc: context.read<CartBloc>(),
        orderRepository: getIt<IOrderRepository>(),
        onOrderCreated: (order) {
          context.read<CartBloc>().add(ClearCart());
          GoRouter.of(context).push(
            '/order/${order.id}',
            extra: order, // Pasar la orden completa
          );
        },
        getUserDirectionsUseCase: getIt<GetUserDirectionsUseCase>(),
        addUserDirectionUseCase: getIt<AddUserDirectionUseCase>(),
        deleteUserDirectionUseCase: getIt<DeleteUserDirectionUseCase>(),
        updateUserDirectionUseCase: getIt<UpdateUserDirectionUseCase>(),
        taxRepository: getIt<ITaxShippinRepository>(),
        paymentMethodRepository: getIt<IPaymentMethodRepository>(),
      )..add(LoadCheckoutData()), // Ensure LoadCheckoutData is dispatched once
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Checkout',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.push("/cart");
                      },
                      icon: Icon(
                        Icons.shopping_bag,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    if (state.cartItemsCount > 0)
                      Positioned(
                        right: 0,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Text(
                            '${state.cartItemsCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              CustomSnackBar.show(
                context,
                type: SnackBarType.error,
                title: 'Error',
                message: state.errorMessage,
              );
              context.read<CheckoutBloc>().add(ClearErrorEvent());
            }
          },
          builder: (context, state) {
            if (state.isProcessing) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShippingAddressSection(),
                  SizedBox(height: 16),
                  DeliveryTimeSection(),
                  SizedBox(height: 16),
                  PaymentMethodSection(),
                  SizedBox(height: 16),
                  OrderSummarySection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
