import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:word_game/features/game/presentation/page/game_page.dart';
import 'package:word_game/features/home/widgets/slider_selection_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double wordLength = 4;
  double attemptsCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Guess It',style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  letterSpacing: 2,
                  color: Theme.of(context).colorScheme.primary
                ),),
                SizedBox(height: 10,),
                Text('By Aditya Upadhyay', style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2
                ),),
                SizedBox(height: 16,),
                Text('Choose your game settings', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                ),),
                SizedBox(
                  height: 32,
                ),
                SliderSelectionWidget(
                    title: 'Word Length',
                    value: wordLength,
                    minValue: 4,
                    maxValue: 7,
                    divisions: 3,
                    onChanged: (value){
                      setState(() {
                        wordLength = value;
                      });
                    }),
                SizedBox(
                  height: 32,
                ),
                SliderSelectionWidget(
                    title: 'Attempts Count',
                    value: attemptsCount,
                    minValue: 3,
                    maxValue: 7,
                    divisions: 4,
                    onChanged: (value){
                      setState(() {
                        attemptsCount = value;
                      });
                    }),
                Spacer(),
                SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      context.push(
                        GamePage.route(
                            wordLength: wordLength.toInt(),
                            attemptsCount: attemptsCount.toInt()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.surface,
                      elevation: 5,
                      shadowColor: Colors.black.withOpacity(0.3)
                    ),
                    child: Text('Start Game',style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
