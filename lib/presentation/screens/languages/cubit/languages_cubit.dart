import 'package:GoDeli/presentation/core/translation/translation_util.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'languages_state.dart';

class LanguagesCubit extends Cubit<LanguagesState> {
  LanguagesCubit() : 
    super(LanguagesState( 
      selected: Translations('Español', 'https://th.bing.com/th/id/OIP.YsBdn_5ODBeaAYawGmu_8wHaE8?rs=1&pid=ImgDetMain'),
      languagesList: Translations.languagesList()
    ));

  void selectLanguage(Translations selected) {
    emit(state.copyWith(selected: selected));
  }
}
