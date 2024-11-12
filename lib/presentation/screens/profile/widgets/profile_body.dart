import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/screens/profile/bloc/bloc.dart';

/// {@template profile_body}
/// Body of the ProfilePage.
///
/// Add what it does
/// {@endtemplate}
class ProfileBody extends StatelessWidget {
  /// {@macro profile_body}
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
