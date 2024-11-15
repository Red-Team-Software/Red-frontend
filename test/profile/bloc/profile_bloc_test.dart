// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GoDeli/presentation/screens/profile/bloc/bloc.dart';

void main() {
  group('ProfileBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          ProfileBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final profileBloc = ProfileBloc();
      expect(profileBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<ProfileBloc, ProfileState>(
      'CustomProfileEvent emits nothing',
      build: ProfileBloc.new,
      act: (bloc) => bloc.add(const CustomProfileEvent()),
      expect: () => <ProfileState>[],
    );
  });
}
