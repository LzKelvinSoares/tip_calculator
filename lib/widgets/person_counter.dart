import 'package:flutter/material.dart';

class PersonCounter extends StatelessWidget {
  const new({
    super.key,
    required this.theme,
    required this.personCount,
    required this.onDecrement,
    required this.onIncrement,
  });

  final ThemeData theme;
  final int personCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: onDecrement, icon: Icon(Icons.remove), color: theme.colorScheme.primary,),
        Text('$personCount', style: theme.textTheme.titleMedium,),
        IconButton(onPressed: onIncrement, icon: Icon(Icons.add), color: theme.colorScheme.primary),
      ],
    );
  }
}