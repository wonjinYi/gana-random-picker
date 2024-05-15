import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile/provider/problem_model.dart';
import 'package:provider/provider.dart';

enum DrawType { letter, pronunciation }

// ----------------------------------
// Draw Type Selector

class DrawTypeSelector extends StatefulWidget {
  const DrawTypeSelector({super.key});

  @override
  State<DrawTypeSelector> createState() => _DrawTypeSelectorState();
}

class _DrawTypeSelectorState extends State<DrawTypeSelector> {
  @override
  Widget build(BuildContext context) {
    String? letter = context.watch<ProblemModel>().letter;
    String? pronunciation = context.watch<ProblemModel>().pronunciation;

    bool isSolving = (letter != null) ^ (pronunciation != null);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: OrientationBuilder(builder: (context, orientation) {
        if (MediaQuery.of(context).orientation == Orientation.portrait) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: isSolving
                ? [
                    ShowAnswerBtn(
                        orientation: MediaQuery.of(context).orientation),
                  ]
                : [
                    DrawLetterBtn(),
                    const SizedBox(width: 12, height: 12),
                    DrawPronunciationBtn(),
                  ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: isSolving
                ? [
                    ShowAnswerBtn(
                        orientation: MediaQuery.of(context).orientation),
                  ]
                : [
                    DrawLetterBtn(),
                    const SizedBox(width: 12, height: 12),
                    DrawPronunciationBtn(),
                  ],
          );
        }
      }),
    );
  }
}

// ----------------------------------

class DrawLetterBtn extends StatelessWidget {
  const DrawLetterBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledBtnWrap(
      drawType: AppLocalizations.of(context)!.letter,
      onPressed: () {
        bool res = context.read<ProblemModel>().drawWithLetter();
        if (!res) {
          ScaffoldMessenger.of(context).showSnackBar(_snackBar(
              AppLocalizations.of(context)!.msgNoFilterSelected, context));
        }
      },
    );
  }
}

class DrawPronunciationBtn extends StatelessWidget {
  const DrawPronunciationBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledBtnWrap(
      drawType: AppLocalizations.of(context)!.pronunciation,
      onPressed: () {
        bool res = context.read<ProblemModel>().drawWithPronunciation();
        if (!res) {
          ScaffoldMessenger.of(context).showSnackBar(_snackBar(
              AppLocalizations.of(context)!.msgNoFilterSelected, context));
        }
      },
    );
  }
}

// ----------------------------------
// Show Answer Btn

class ShowAnswerBtn extends StatelessWidget {
  const ShowAnswerBtn({super.key, required this.orientation});
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton(
        onPressed: () {
          context.read<ProblemModel>().showAll();
        },
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          minimumSize: const Size(100, 100),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double parentWidth = constraints.maxWidth;
            double fontSize = parentWidth *
                0.12 *
                (orientation == Orientation.portrait ? 0.5 : 1);

            return AutoSizeText(
              AppLocalizations.of(context)!.showAnswer,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w300),
              maxFontSize: 32,
            );
          },
        ),
      ),
    );
  }
}

//

class FilledBtnWrap extends StatelessWidget {
  const FilledBtnWrap(
      {super.key, required this.drawType, required this.onPressed});
  final String drawType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton(
        onPressed: () {
          onPressed();
        },
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          minimumSize: const Size(100, 100),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double parentWidth = constraints.maxWidth;
            double fontSize = parentWidth * 0.13;

            return AutoSizeText(
              '${drawType}',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w300),
              maxFontSize: 32,
            );
          },
        ),
      ),
    );
  }
}

// ----------------------------------
// Snackbar

SnackBar _snackBar(String message, BuildContext context) {
  return SnackBar(
    content: Text(message,
        style: TextStyle(color: Theme.of(context).colorScheme.onError)),
    closeIconColor: Theme.of(context).colorScheme.onError,
    showCloseIcon: true,
    duration: const Duration(seconds: 1),
    backgroundColor: Theme.of(context).colorScheme.error,
  );
}


//
// child:AnimatedSwitcher(
      //   duration: const Duration(milliseconds: 300),
      //   transitionBuilder: (Widget child, Animation<double> animation) {
      //     return FadeTransition(
      //       opacity: animation,
      //       child: child,
      //     );
      //   },
      //   child: isSolving
      //       ? ShowAnswerBtn(
      //           onTap: () {
      //             context.read<ProblemModel>().showAll();
      //           },
      //         )
      //       : Row(
      //           // strech two buttons to fill the row
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             FilledBtnWrap(
      //               drawType: AppLocalizations.of(context)!.letter,
      //               onPressed: () {
      //                 context.read<ProblemModel>().drawWithLetter();
      //               },
      //             ),
      //             SizedBox(width: isSolving ? 0 : 12),
      //             FilledBtnWrap(
      //               drawType: AppLocalizations.of(context)!.pronunciation,
      //               onPressed: () {
      //                 context.read<ProblemModel>().drawWithPronunciation();
      //               },
      //             ),
      //           ],
      //         ),
      // ),