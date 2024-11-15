import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/screens/profile/bloc/bloc.dart';
import 'package:GoDeli/presentation/screens/profile/widgets/profile_body.dart';

/// {@template profile_page}
/// A description for ProfilePage
/// {@endtemplate}
class ProfilePage extends StatelessWidget {
  /// {@macro profile_page}
  ///
  ///
  const ProfilePage({super.key});
  static const String name = 'profile_page';

  /// The static route for ProfilePage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: const Scaffold(
        body: ProfileView(),
      ),
    );
  }
}

/// {@template profile_view}
/// Displays the Body of ProfileView
/// {@endtemplate}
class ProfileView extends StatelessWidget {
  /// {@macro profile_view}
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileBody();
  }
}
