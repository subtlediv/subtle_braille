import 'package:braille_mobile/constants/constants.dart';
import 'package:braille_mobile/constants/styles.dart';
import 'package:braille_mobile/logic/cubits/cubit/home_page_cubit.dart';
import 'package:braille_mobile/presentation/braille_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _ipTextController;

  @override
  void initState() {
    _ipTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: GRADE1,
                      child: Text(
                        "Grade 1",
                        style: TextStyle(
                            color: state.grade == GRADE1
                                ? Colors.black
                                : Colors.grey),
                      )),
                  PopupMenuItem<int>(
                      value: GRADE2,
                      child: Text(
                        "Grade 2",
                        style: TextStyle(
                            color: state.grade == GRADE2
                                ? Colors.black
                                : Colors.grey),
                      )),
                ],
                onSelected: (value) =>
                    BlocProvider.of<HomePageCubit>(context).setGrade(value),
              ),
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _ipTextController,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          hintText: "Enter text to be converted to Braille"),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: onPressConvert, child: const Text("Convert")),
                ],
              ),
              Expanded(
                  child:
                      // BlocBuilder<HomePageCubit, HomePageState>(
                      //   builder: (context, state) {
                      (state.convertedText.isEmpty)
                          ? Container()
                          : GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2 / 3,
                                      crossAxisCount: (MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              (dotSize * 2 + dotPaddingMax * 4))
                                          .floor()),
                              itemCount: state.convertedText.length,
                              itemBuilder: (context, index) {
                                return BrailleCellWithLabel(
                                  labelCodeTuple: state.convertedText[index],
                                  dotSize: dotSize,
                                );
                              })
                  // },
                  //   ),
                  )
            ],
          ),
        );
      },
    );
  }

  void onPressConvert() => BlocProvider.of<HomePageCubit>(context)
      .onNewTextInput(_ipTextController.text);
}
