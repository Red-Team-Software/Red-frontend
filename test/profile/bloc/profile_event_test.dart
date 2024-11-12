// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:GoDeli/presentation/screens/profile/bloc/bloc.dart';

void main() {
  group('ProfileEvent', () {  
    group('CustomProfileEvent', () {
      test('supports value equality', () {
        expect(
          CustomProfileEvent(),
          equals(const CustomProfileEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomProfileEvent(),
          isNotNull
        );
      });
    });
  });
}
