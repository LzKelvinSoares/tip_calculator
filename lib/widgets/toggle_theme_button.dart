import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tip_calculator/widgets/providers/ThemeProvider.dart';

class ToggleThemeButton extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      icon: Icon(themeProvider.themeIcon),
      onPressed: themeProvider.toggleTheme,
    );
  }
}