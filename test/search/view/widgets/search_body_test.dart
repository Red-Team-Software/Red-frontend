// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/screens/search/search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => SearchBloc(),
          child: MaterialApp(home: SearchBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
