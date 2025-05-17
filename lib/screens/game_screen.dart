import 'package:devhub_xo/blocs/game/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatelessWidget {
  late String info = "Player X";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XO Game with Cubit States'),
        centerTitle: true,
      ),
      body: BlocConsumer<GameCubit, GameState>(
        listener: (context, state) {
          if (state is GameInitial){
            info = "Player X";
          }
          if (state is GamePlayState){
            info = "Player ${state.player}";
          }
          if(state is GameDrawState){
            info = "Game is Draw";
          }
          if(state is GameWinState){
            info = "Player ${state.player}  is Winner";
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                info,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => context.read<GameCubit>().playGame(index),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: Text(
                            context.read<GameCubit>().board[index],
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => context.read<GameCubit>().resetGame(),
                child: const Text('Restart Game'),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
