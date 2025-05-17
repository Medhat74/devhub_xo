import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';

  void playGame(int index){
    // check the cell is Ava
    if (board[index] != '' || state is GameWinState ){
      return;
    }

    board[index] = currentPlayer;

    // check win
    String winner = checkWinner();
    if(winner != ''){
      emit(GameWinState(winner));
    }

    // check draw
    else if(!board.contains('')){
      emit(GameDrawState());
    }

    //change player
    else {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      emit(GamePlayState(currentPlayer));
    }


  }


  String checkWinner() {
    const winningCombos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombos) {
      final a = combo[0];
      final b = combo[1];
      final c = combo[2];

      if (board[a] != '' && board[a] == board[b] && board[a] == board[c]) {
        return board[a];
      }
    }

    return '';
  }

  void resetGame(){
    board = List.filled(9, '');
    currentPlayer = 'X';
    emit(GameInitial());
  }


}
