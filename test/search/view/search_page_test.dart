// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/screens/search/search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchPage', () {
    group('route', () {
      test('is routable', () {
        expect(SearchPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders SearchView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: SearchPage()));
      expect(find.byType(SearchView), findsOneWidget);
    });
  });
}
