import 'package:flutter/material.dart';

class LetterBoxWidget extends StatelessWidget {
  final Color? boxColor;
  final Color? textColor;
  final String text;
  const LetterBoxWidget({super.key, this.boxColor, this.textColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(duration: Duration(milliseconds: 500),
    curve: Curves.easeIn,
    margin: EdgeInsets.symmetric(horizontal: 4),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: boxColor,
      borderRadius: BorderRadius.circular(12),
      border: boxColor == null ? Border.all(color: Theme.of(context).colorScheme.onSurface) : null
    ),
      child: Center(
        child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold
        )),
      ),
    );
  }
}
