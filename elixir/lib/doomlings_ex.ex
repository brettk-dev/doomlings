defmodule DoomlingsEx do
  @moduledoc """
  Documentation for `DoomlingsEx`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DoomlingsEx.hello()
      :world

  """
  def hello do
    :world
  end

  def get_int(prompt) do
    IO.puts(prompt)

    input = IO.gets("") |> String.trim()

    case Integer.parse(input) do
      {n, ""} -> n
      _ -> get_int(prompt)
    end
  end

  def create_players(n, max, players \\ [])

  def create_players(n, max, players) when n > max do
    Enum.reverse(players)
  end

  def create_players(n, max, players) do
    IO.puts("What is player #{n}'s name? (#{max})")

    name =
      case IO.gets("") |> String.trim() do
        "" -> "Player #{n}"
        name -> name
      end

    player = {name, 0}
    create_players(n + 1, max, [player | players])
  end

  def get_score(score_type, name) do
    get_int("#{name}, what are your #{score_type} points?")
  end

  def start(_, _) do
    IO.puts("")
    IO.puts(":::: DOOMLINGS SCORE CALCULATOR ::::")
    IO.puts("")

    player_count = get_int("How many people are playing?")

    IO.puts("")
    players = create_players(1, player_count)

    IO.puts("")

    players =
      Enum.map(players, fn {name, score} ->
        {name, score + get_score("World's End", name)}
      end)

    IO.puts("")

    players =
      Enum.map(players, fn {name, score} ->
        {name, score + get_score("Face Value", name)}
      end)

    IO.puts("")

    players =
      Enum.map(players, fn {name, score} ->
        {name, score + get_score("Bonus", name)}
      end)

    IO.puts("")
    IO.puts("")

    IO.puts(
      "#{String.pad_trailing("#", 2)}#{String.pad_trailing("PLAYER", 16)}#{String.pad_leading("SCORE", 5)}"
    )

    IO.puts("")

    players
    |> Enum.sort_by(fn {_, s} -> s end, :desc)
    |> Enum.with_index()
    |> Enum.each(fn {{name, score}, i} ->
      rank_str = Integer.to_string(i + 1)
      score_str = Integer.to_string(score)

      IO.puts(
        "#{String.pad_trailing(rank_str, 2)}#{String.pad_trailing(name, 16)}#{String.pad_leading(score_str, 5)}"
      )
    end)

    IO.puts("")

    System.halt(0)
  end

  def main(_args) do
    IO.puts("Hello from MyApp!")
  end
end
