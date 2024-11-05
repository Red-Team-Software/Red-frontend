import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/screens/auth/bloc/bloc.dart';

/// {@template auth_body}
/// Body of the AuthPage.
///
/// Add what it does
/// {@endtemplate}
class AuthBody extends StatelessWidget {
  /// {@macro auth_body}
  const AuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
