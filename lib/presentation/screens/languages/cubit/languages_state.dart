part of 'languages_cubit.dart';

class LanguagesState extends Equatable {

  final Translations selected;
  final List<Translations> languagesList;

  const LanguagesState({
    required this.selected,
    required this.languagesList,
  });

  set selected(Translations selected) => selected = selected;

  copyWith({
    Translations? selected,
    List<Translations>? languagesList,
  }) {
    return LanguagesState(
      selected: selected ?? this.selected,
      languagesList: languagesList ?? this.languagesList,
    );
  }

  @override
  List<Object> get props => [selected, languagesList];
}
