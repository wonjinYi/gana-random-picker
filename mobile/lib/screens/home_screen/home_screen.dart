import 'package:flutter/material.dart';
import 'package:mobile/provider/problem_model.dart';
import 'package:mobile/screens/home_screen/widgets/contents_display.dart';
import 'package:mobile/screens/home_screen/widgets/draw_type_selector.dart';
import 'package:mobile/screens/home_screen/widgets/letter_type_selector.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProblemModel>(
      create: (_) => ProblemModel(),
      child: Scaffold(
        body: SafeArea(
          child: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return const Column(
                children: [
                  Expanded(child: ContentsDisplay()),
                  LetterTypeSelector(),
                  DrawTypeSelector(),
                ],
              );
            } else {
              return const Column(
                children: [
                  LetterTypeSelector(),
                  Expanded(
                    child: Row(children: [
                      Expanded(flex: 2, child: ContentsDisplay()),
                      Expanded(flex: 1, child: DrawTypeSelector()),
                    ]),
                  )
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
