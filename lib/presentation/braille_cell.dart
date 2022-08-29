import 'package:braille_mobile/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class BrailleCellWithLabel extends StatelessWidget {
  final Tuple2<String, String> labelCodeTuple;
  final double dotSize;
  const BrailleCellWithLabel(
      {required this.labelCodeTuple, this.dotSize = 20, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BrailleCell(
          code: labelCodeTuple.item2,
          dotSize: dotSize,
        ),
        Text(labelCodeTuple.item1)
      ],
    );
  }
} 

class BrailleCell extends StatelessWidget {
  final String code;
  final double dotSize;
  const BrailleCell({required this.code, this.dotSize = 20, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: _getRows(),
      ),
    );
  }

  List<Widget> _getRows() {
    List<Widget> table = List<Widget>.empty(growable: true);
    for (int i = 0; i < 3; i++) {
      table.add(Row(mainAxisSize: MainAxisSize.min, children: [
        BrailleDot(
          color: getDotColor(code, i * 2),
          size: dotSize,
        ),
        BrailleDot(color: getDotColor(code, i * 2 + 1), size: dotSize)
      ]));
    }
    return table;
  }

  Color getDotColor(String code, int index) {
    if (code.isEmpty) return errorDotColor;

    return (code[index] == '1') ? filledDotColor : emptyDotColor;
  }
}

class BrailleDot extends StatelessWidget {
  final Color color;
  final double size;
  const BrailleDot({required this.color, Key? key, this.size = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      //?TODO: correct spacing ratio
      padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: dotBorderColor)),
      ),
    );
  }
}


// child: GridView.builder(
//   shrinkWrap: true,
//   itemCount: 6,
//   gridDelegate:
//       const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//   itemBuilder: (BuildContext context, int index) {
//     if (code.isEmpty) {
//       return const BrailleDot(color: errorDotColor);
//     } else {
//       return BrailleDot(
//           color: (code[index] == '1')
//             ? filledDotColor
//             : emptyDotColor
//         );
//     }
//   },
// ),
