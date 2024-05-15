import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile/provider/problem_model.dart';
import 'package:provider/provider.dart';
import 'package:mobile/global_variables.dart';

// ------------------------------------------------------
// Letter Type Selector ---------------------------------

class LetterTypeSelector extends StatefulWidget {
  const LetterTypeSelector({super.key});

  @override
  State<LetterTypeSelector> createState() => _LetterTypeSelectorState();
}

class _LetterTypeSelectorState extends State<LetterTypeSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const LetterTypeChips(),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push('/setting');
            },
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------
// Letter Type Chips ------------------------------------

class LetterTypeChips extends StatefulWidget {
  const LetterTypeChips({super.key});

  @override
  State<LetterTypeChips> createState() => _LetterTypeChipsState();
}

class _LetterTypeChipsState extends State<LetterTypeChips> {
  @override
  Widget build(BuildContext context) {
    bool _noFilter = context.watch<ProblemModel>().noFilter;
    return Row(
      children: [
        ChoiceChip(
          label: Text(AppLocalizations.of(context)!.hiragana),
          selected:
              context.watch<ProblemModel>().isIncludedFilter(Filter.hiragana),
          onSelected: (_) {
            context.read<ProblemModel>().updateFilter(Filter.hiragana);
          },
          side: BorderSide(color: Colors.transparent),
          labelStyle: _noFilter
              ? TextStyle(color: Theme.of(context).colorScheme.onError)
              : TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          selectedColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: _noFilter
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.tertiary,
        ),
        const SizedBox(width: 12),
        ChoiceChip(
          label: Text(AppLocalizations.of(context)!.katakana),
          selected:
              context.watch<ProblemModel>().isIncludedFilter(Filter.katakana),
          onSelected: (_) {
            context.read<ProblemModel>().updateFilter(Filter.katakana);
          },
          side: BorderSide(color: Colors.transparent),
          labelStyle: _noFilter
              ? TextStyle(color: Theme.of(context).colorScheme.onError)
              : TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          selectedColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: _noFilter
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.tertiary,
        ),
        // ChoiceChip(
        //   label: Text(AppLocalizations.of(context)!.hiragana),
        //   selected: selectedLetterType.contains(LetterType.hiragana),
        //   onSelected: (bool selected) {
        //     setState(() {
        //       handleSelected(LetterType.hiragana, selected);
        //     });
        //   },
        //   side: BorderSide(color: Colors.transparent),
        //   backgroundColor:
        //       Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
        // ),
        // const SizedBox(width: 12),
        // ChoiceChip(
        //   label: Text(AppLocalizations.of(context)!.katakana),
        //   selected: selectedLetterType.contains(LetterType.katakana),
        //   onSelected: (bool selected) {
        //     setState(() {
        //       handleSelected(LetterType.katakana, selected);
        //     });
        //   },
        //   side: BorderSide(color: Colors.transparent),
        //   backgroundColor:
        //       Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
        // ),
      ],
    );
  }
}
