import 'package:braille_mobile/constants/constants.dart';
import 'package:braille_mobile/logic/text_to_braille/braille_dictionary.dart';
import 'package:tuple/tuple.dart';

List<Tuple2<String, String>> addAllTuples(String char, int dictType) {
  Map<String, List<String>> dict;
  switch (dictType) {
    case BRAILLE_DICT:
      dict = brailleDict;
      break;
    case SHORTHAND_WORDS:
      dict = shorthandWords;
      break;
    case COMMON_PATTERNS:
      dict = commonPatterns;
      break;
    default:
      throw Exception("Invalid Dictionary Type");
  }
  List<Tuple2<String, String>> tuples =
      List<Tuple2<String, String>>.empty(growable: true);
  if (char == CAP || char == ALL_CAPS) {
    for (String code in dict[char]!) {
      tuples.add(Tuple2<String, String>('<$CAP>', code));
    }
  } else if (char == LTR) {
  } else if (char == NUM) {
  } else if (char == ERR) {
  } else {
    List<String>? codes = dict[char];
    if (codes == null) {
      tuples.addAll(addAllTuples(ERR, BRAILLE_DICT));
    } else {
      for (int i = 0; i < codes.length; i++) {
        if (i != codes.length - 1) {
          tuples.add(Tuple2<String, String>('', codes[i]));
        } else {
          tuples.add(Tuple2(char, codes[i]));
        }
      }
    }
  }

  return tuples;
}

bool isAllCaps(String word) =>
    (word.contains(RegExp(r'[A-Z]')) || word.contains(RegExp(r'[a-z]'))) &&
    word.toUpperCase() == word;

bool isUpperCase(String char) {
  if (char.length > 1) {
    throw Exception("Input is not a character");
  }
  return isAllCaps(char);
}

bool isShorthandWord(String word) => shorthandWords[word] != null;
