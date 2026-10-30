

import 'package:flutter/material.dart';

class TotalPerPerson extends StatelessWidget {
  const new({
    super.key,
    required this.theme,
    required this.style,
    required this.total,
  });

  final ThemeData theme;
  final TextStyle style;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0), 
      child: 
        Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Text(
                "Total per person", 
                style: style
              ),
              Text(
                "\$${total.toStringAsFixed(2)}", 
                style: style.copyWith(fontSize: theme.textTheme.displaySmall?.fontSize)
              ),
            ],
          )
        ),
    );
  }
}
