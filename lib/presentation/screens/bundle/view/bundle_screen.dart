
import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/bundles/application/bundle_details/bundle_details_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class BundleScreen extends StatelessWidget {
  static const String name = 'details_bundle_screen';

  final String idBundle;
  const BundleScreen({super.key, required this.idBundle});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BundleDetailsBloc>()..getBundleById(idBundle),
      child: const _BundleView(),
    );
  }
}

class _BundleView extends StatelessWidget {
  const _BundleView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BundleBody(theme: theme);
  }
}
