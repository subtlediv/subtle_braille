import 'package:braille_mobile/constants/constants.dart';
import 'package:braille_mobile/logic/text_to_braille/braille_dictionary.dart';
import 'package:braille_mobile/logic/text_to_braille/common_functions.dart';
import 'package:tuple/tuple.dart';

List<Tuple2<String, String>> textToGrade2Braille(String ipText) {
  List<Tuple2<String, String>> brailleCode =
      List<Tuple2<String, String>>.empty(growable: true);
  List<String> words = ipText.split(' ');
  for (int i = 0; i < words.length; i++) {
    String word = words[i];
    // print(word);

    if (isAllCaps(word)) {
      brailleCode.addAll(addAllTuples(ALL_CAPS, BRAILLE_DICT));
      word.toLowerCase();
      brailleCode.addAll(textToGrade2Braille(word));
    } else if (isShorthandWord(word)) {
      brailleCode.addAll(addAllTuples(word, SHORTHAND_WORDS));
      if (i != words.length - 1) {
        brailleCode.addAll(addAllTuples(' ', BRAILLE_DICT));
      }
      continue;
    } else {
      List<Tuple2<String, String>> brailleWord =
          List<Tuple2<String, String>>.empty(growable: true);
      for (int j = 0; j < word.length; j++) {
        if (isUpperCase(word[j])) {
          brailleWord.addAll(addAllTuples(CAP, BRAILLE_DICT));
          //TODO: verify handling of capitals in patterns
        }
        int k = 3;
        for (; k > 0; k--) {
          if (j + k < word.length &&
              commonPatterns[word.substring(j, j + k + 1).toLowerCase()] != null) {
            brailleWord.addAll(
                addAllTuples(word.substring(j, j + k + 1).toLowerCase(), COMMON_PATTERNS));
            j = j + k;
            k = -1; //flag that
            break;
          }
        }
        if (k != -1) {
          brailleWord.addAll(addAllTuples(word[j].toLowerCase(), BRAILLE_DICT));
        }
      }

      brailleCode.addAll(brailleWord);

      if (i != words.length - 1) {
        brailleCode.addAll(addAllTuples(' ', BRAILLE_DICT));
      }
    }
  }
  return brailleCode;
}
