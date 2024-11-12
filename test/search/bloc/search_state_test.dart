// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:GoDeli/presentation/screens/search/bloc/bloc.dart';

void main() {
  group('SearchState', () {
    test('supports value equality', () {
      expect(
        SearchState(),
        equals(
          const SearchState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const SearchState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const searchState = SearchState(
            customProperty: 'My property',
          );
          expect(
            searchState.copyWith(),
            equals(searchState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const searchState = SearchState(
            customProperty: 'My property',
          );
          final otherSearchState = SearchState(
            customProperty: 'My property 2',
          );
          expect(searchState, isNot(equals(otherSearchState)));

          expect(
            searchState.copyWith(
              customProperty: otherSearchState.customProperty,
            ),
            equals(otherSearchState),
          );
        },
      );
    });
  });
}
