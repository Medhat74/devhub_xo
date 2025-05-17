part of 'game_cubit.dart';

@immutable
sealed class GameState {}

final class GameInitial extends GameState {}

final class GamePlayState extends GameState {
  String player;

  GamePlayState(this.player);
}
final class GameDrawState extends GameState {}
final class GameWinState extends GameState {

  String player;

  GameWinState(this.player);
}
