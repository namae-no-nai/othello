# Othello Game in Elixir

## Overview

This Elixir module implements a simplified version of the classic board game **Othello**. The game is played on an 8x8 grid, where two players, represented by black (`B`) and white (`W`) pieces, alternate turns. The goal is to capture opponent pieces by trapping them between your own pieces, flipping them to your color.

The module handles core game mechanics like initializing the board, validating moves, flipping pieces, and switching between players.

## Features

- **Board Initialization**: The game begins with an 8x8 board, with four pieces placed at the center: two black and two white pieces.
- **Move Validation**: Ensures that a player's move is valid by checking if it can capture the opponent's pieces.
- **Piece Flipping**: When a move is valid, the opponent's pieces between two of the current player's pieces are flipped.
- **Turn-Based Gameplay**: The game alternates between black and white players, prompting them to enter their moves.

## Functions
a# Othello Game in Elixir

## Overview

This Elixir module implements a simplified version of the classic board game **Othello**. The game is played on an 8x8 grid, where two players, represented by black (`B`) and white (`W`) pieces, alternate turns. The goal is to capture opponent pieces by trapping them between your own pieces, flipping them to your color.

The module handles core game mechanics like initializing the board, validating moves, flipping pieces, and switching between players.

## Features

- **Board Initialization**: The game begins with an 8x8 board, with four pieces placed at the center: two black and two white pieces.
- **Move Validation**: Ensures that a player's move is valid by checking if it can capture the opponent's pieces.
- **Piece Flipping**: When a move is valid, the opponent's pieces between two of the current player's pieces are flipped.
- **Turn-Based Gameplay**: The game alternates between black and white players, prompting them to enter their moves.

## How to Play

1. Run the `Othello.start_game()` function to start the game.
2. The game will display the current board and prompt the players to input their moves.
3. Players take turns entering their move as `{row, col}`. The row and column should be entered as numbers (e.g., `{4, 5}`).
4. The game will validate the move and either apply it or prompt the player to try again.
5. The game continues until no valid moves are left for either player.

## Example of a Move

```plaintext
  1 2 3 4 5 6 7 8
1 . . . . . . . .
2 . . . . . . . .
3 . . . . . . . .
4 . . . W B . . .
5 . . . B W . . .
6 . . . . . . . .
7 . . . . . . . .
8 . . . . . . . .

Current player: B
Enter move as {row, col}:
4,3

  1 2 3 4 5 6 7 8
1 . . . . . . . .
2 . . . . . . . .
3 . . . . . . . .
4 . . B B B . . .
5 . . . B W . . .
6 . . . . . . . .
7 . . . . . . . .
8 . . . . . . . .

Current player: W
Enter move as {row, col}:
