// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:GoDeli/presentation/screens/auth/bloc/bloc.dart';

void main() {
  group('AuthState', () {
    test('supports value equality', () {
      expect(
        AuthState(),
        equals(
          const AuthState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const AuthState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const authState = AuthState(
            customProperty: 'My property',
          );
          expect(
            authState.copyWith(),
            equals(authState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const authState = AuthState(
            customProperty: 'My property',
          );
          final otherAuthState = AuthState(
            customProperty: 'My property 2',
          );
          expect(authState, isNot(equals(otherAuthState)));

          expect(
            authState.copyWith(
              customProperty: otherAuthState.customProperty,
            ),
            equals(otherAuthState),
          );
        },
      );
    });
  });
}
