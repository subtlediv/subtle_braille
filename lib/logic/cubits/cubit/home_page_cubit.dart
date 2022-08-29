import 'package:bloc/bloc.dart';
import 'package:braille_mobile/constants/constants.dart';
import 'package:braille_mobile/logic/text_to_braille/text_to_braille_grade1.dart';
import 'package:braille_mobile/logic/text_to_braille/text_to_braille_grade2.dart';
import 'package:tuple/tuple.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
      : super(HomePageState(
            convertedText: List<Tuple2<String, String>>.empty(),
            grade: GRADE1));

  void onNewTextInput(String text) => emit(HomePageState(
      convertedText: state.grade == GRADE1
          ? textToGrade1Braille(text)
          : textToGrade2Braille(text),
      grade: state.grade));

  void setGrade(int grade) =>
      emit(HomePageState(convertedText: state.convertedText, grade: grade));
}
