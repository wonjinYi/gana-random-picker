import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile/provider/problem_model.dart';
import 'package:provider/provider.dart';

class ContentsDisplay extends StatefulWidget {
  const ContentsDisplay({super.key});

  @override
  State<ContentsDisplay> createState() => _ContentsDisplayState();
}

class _ContentsDisplayState extends State<ContentsDisplay> {
  @override
  Widget build(BuildContext context) {
    String? letter = context.watch<ProblemModel>().letter;
    String? pronunciation = context.watch<ProblemModel>().pronunciation;

    return Column(
      children: [
        ProblemCard(
            title: AppLocalizations.of(context)!.letter, content: letter),
        ProblemCard(
            title: AppLocalizations.of(context)!.pronunciation,
            content: pronunciation),
      ],
    );
  }
}

class ProblemCard extends StatelessWidget {
  const ProblemCard({super.key, required this.title, required this.content});
  final String title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
            vertical: BorderSide.none,
          ),
          borderRadius: BorderRadius.circular(8),
          // color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: AutoSizeText(
                    content ?? '',
                    style: Theme.of(context).textTheme.displayLarge,
                    minFontSize: 32,
                    maxFontSize: 128,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
