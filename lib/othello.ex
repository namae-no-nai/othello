defmodule Othello do
  @moduledoc """
  Othello game implementation in Elixir.
  """

  @board_size 8
  @empty "."
  @black "B"
  @white "W"
  @directions [
    {-1, -1}, {-1, 0}, {-1, 1},
    {0, -1},          {0, 1},
    {1, -1}, {1, 0},  {1, 1}
  ]

  @doc """
  Starts a new Othello game.
  Initializes the game board and enters the game loop with the black player starting.
  """
  def start_game do
    board = create_board()
    initial_board = place_initial_pieces(board)
    display_board(initial_board)
    game_loop(initial_board, @black)
  end

  @doc """
  Creates an empty 8x8 Othello board.
  """
  defp create_board do
    for _ <- 1..@board_size, do: for _ <- 1..@board_size, do: @empty
  end

  @doc """
  Places the initial four pieces in the center of the board: two black and two white.
  """
  defp place_initial_pieces(board) do
    board
    |> put_piece({3, 3}, @white)
    |> put_piece({3, 4}, @black)
    |> put_piece({4, 3}, @black)
    |> put_piece({4, 4}, @white)
  end

  @doc """
  Displays the current state of the board in the console.
  """
  defp display_board(board) do
    IO.puts "  1 2 3 4 5 6 7 8"
    Enum.with_index(board, 1)
    |> Enum.each(fn {row, index} -> 
      IO.puts "#{index} " <> Enum.join(row, " ")
    end)
  end

  @doc """
  Main game loop that alternates between players, accepting and validating moves.
  """
  defp game_loop(board, current_player) do
    IO.puts "Current player: #{current_player}"
    IO.puts "Enter move as {row, col}: "
    {row, col} = get_move()

    if valid_move?(board, {row, col}, current_player) do
      new_board = make_move(board, {row, col}, current_player)
      display_board(new_board)
      next_player = if current_player == @black, do: @white, else: @black
      game_loop(new_board, next_player)
    else
      IO.puts "Invalid move! Try again."
      game_loop(board, current_player)
    end
  end

  @doc """
  Prompts the user to enter a move in the format `{row, col}`.
  Returns the parsed coordinates adjusted for zero-based indexing.
  Defaults to returning position {4, 4} in case of an error.
  """
  defp get_move do
    input = IO.gets("") |> String.trim()
    
    {row_str, col_str} = input
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()

    {row_str - 1, col_str - 1}
  rescue
    [MatchError, ArgumentError] ->
      {4, 4}
  end

  @doc """
  Checks if a move is valid by ensuring the selected cell is empty
  and that it results in at least one piece being flipped.
  """
  defp valid_move?(board, {row, col}, player) do
    get_piece(board, {row, col}) == @empty && flip_positions(board, {row, col}, player) != []
  end

  @doc """
  Executes a valid move by placing the player's piece and flipping the opponent's pieces.
  """
  defp make_move(board, {row, col}, player) do
    board = put_piece(board, {row, col}, player)
    flip_positions(board, {row, col}, player)
    |> Enum.reduce(board, fn {r, c}, acc_board ->
      put_piece(acc_board, {r, c}, player)
    end)
  end

  @doc """
  Places a piece on the board at the specified coordinates for the given player.
  """
  defp put_piece(board, {row, col}, player) do
    List.update_at(board, row, fn row_list ->
      List.update_at(row_list, col, fn _ -> player end)
    end)
  end

  @doc """
  Finds all positions of opponent's pieces that should be flipped as a result of a move.
  Returns a list of positions to be flipped.
  """
  defp flip_positions(board, {row, col}, player) do
    Enum.flat_map(@directions, fn {dr, dc} ->
      gather_flips_in_direction(board, {row, col}, {dr, dc}, player)
    end)
  end

  @doc """
  Recursively gathers opponent's pieces that should be flipped in a given direction.
  """
  defp gather_flips_in_direction(board, {row, col}, {dr, dc}, player, flips \\ []) do
    next_pos = {row + dr, col + dc}

    if in_bounds?(next_pos) do
      case get_piece(board, next_pos) do
        ^player -> flips
        @empty -> []
        opponent_piece -> 
          gather_flips_in_direction(board, next_pos, {dr, dc}, player, [next_pos | flips])
      end
    else
      []
    end
  end

  @doc """
  Checks if a given position is within the bounds of the board.
  """
  defp in_bounds?({row, col}) do
    row >= 0 and row < @board_size and col >= 0 and col < @board_size
  end

  @doc """
  Returns the piece at a given board position.
  """
  defp get_piece(board, {row, col}) do
    Enum.at(Enum.at(board, row), col)
  end
end

Othello.start_game()
