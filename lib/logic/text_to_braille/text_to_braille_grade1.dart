import 'package:braille_mobile/constants/constants.dart';
import 'package:braille_mobile/logic/text_to_braille/braille_dictionary.dart';
import 'package:braille_mobile/logic/text_to_braille/common_functions.dart';
import 'package:tuple/tuple.dart';

List<Tuple2<String, String>> textToGrade1Braille(String ipText) {
  List<Tuple2<String, String>> brailleCode =
      List<Tuple2<String, String>>.empty(growable: true);
  List<String> words = ipText.split(' ');
  for (int i = 0; i < words.length; i++) {
    String word = words[i];
    // print(word);
    if (isAllCaps(word)) {
      brailleCode.addAll(addAllTuples(ALL_CAPS, BRAILLE_DICT));
      word.toLowerCase();
    }

    List<Tuple2<String, String>> brailleWord =
        List<Tuple2<String, String>>.empty(growable: true);
    for (int j = 0; j < word.length; j++) {
      if (isUpperCase(word[j])) {
        brailleWord.add(Tuple2<String, String>(
            '', brailleDict[CAP]![0])); 
      }
      brailleWord.addAll(addAllTuples(word[j], BRAILLE_DICT));
    }

    brailleCode.addAll(brailleWord);
    if (i != words.length - 1) {
      brailleCode.add(Tuple2<String, String>(' ', brailleDict[' ']![0]));
    }
  }
  return brailleCode;
}
