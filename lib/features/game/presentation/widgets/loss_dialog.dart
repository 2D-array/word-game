import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

class LossDialog extends StatelessWidget {
  final String word;

  const LossDialog({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: AppColors.red,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sentiment_very_dissatisfied_outlined,
            size: 60,
            color: Theme.of(context).colorScheme.surface,
          ),
          const SizedBox(height: 20),
          Text(
            'Boooooo Loooser!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            'The correct answer is: $word!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
              onPressed: (){
                context.pop();
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Play Again',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),))
        ],
      ),
    );
  }
}
