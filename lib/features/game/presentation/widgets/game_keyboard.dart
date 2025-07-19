import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_game/core/theme/app_colors.dart';

import '../bloc/game_bloc.dart';
import '../bloc/game_state.dart';

class GameKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  final Function() onDelete;
  final Function() onSubmit;

  const GameKeyboard({super.key, required this.onKeyPressed, required this.onDelete, required this.onSubmit});


  @override
  Widget build(BuildContext context) {
    const rows = [
      'QWERTYUIOP',
      'ASDFGHJKL',
      'ZXCVBNM'
    ];

    return BlocBuilder <GameBloc, GameState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...rows.map((row) => _buildKeyboardRow(BuildContext, context, state, row)),
              SizedBox(height: 10,),
              _buildActionRow(context, state)
            ],
          ),
        );
      }
    );
  }

  Widget _buildKeyboardRow(BuildContext, context, GameState state, String row){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: row.split('').map((key)=> _buildKey(context, state, key)).toList(),
    );
  }
  
  Widget _buildActionRow(BuildContext context, GameState state){
    var currentAttempts = state.currentAttempts ?? '';
    var word = state.word ?? '';
    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 3,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: (){
                  onDelete();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)
                  ),
                ),
                child: Icon(
                  Icons.backspace,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 3,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: currentAttempts.length < word.length ? null : (){
                  onSubmit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)
                  ),
                ),
                child: Text('Enter',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKey(BuildContext context, GameState state, String key){
    return Expanded(
      child: AspectRatio(
          aspectRatio: 0.8,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ElevatedButton(
              onPressed: () => onKeyPressed(key),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: getKeyColor(context, state, key),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )
              ),
              child: Text(key, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: getTextColor(context, state, key)
              ),),
            ),
          ),
      ),
    );
  }

  Color getKeyColor(BuildContext context, GameState state, String key){
    final attempts = state.attempts ?? [];
    final word = state.word ?? '';

    for(final attempt in attempts){
      for(int i = 0; i < attempt.length; i++){
        if(attempt[i] == key && key == word[i]){
          return AppColors.green;
        }
      }
    }

    if(word.contains(key)){
      for(final attempt in attempts){
        if(attempt.contains(key)){
          return AppColors.yellow;
        }
      }
    }

    for(final attempt in attempts){
      if(attempt.contains(key)){
        return Theme.of(context).colorScheme.onSurfaceVariant;
      }
    }

    return Theme.of(context).colorScheme.surface;
  }

  Color getTextColor(BuildContext context, GameState state, String key){
    final attempts = state.attempts ?? [];
    final word = state.word ?? '';

    for(final attempt in attempts){
      for(int i = 0; i < attempt.length; i++){
        if(attempt[i] == key && key == word[i]){
          return Theme.of(context).colorScheme.surface;
        }
      }
    }

    if(word.contains(key)){
      for(final attempt in attempts){
        if(attempt.contains(key)){
          return Theme.of(context).colorScheme.surface;
        }
      }
    }

    return Theme.of(context).colorScheme.onSurface;
  }
}
