defmodule ResuelveFc do
  @moduledoc """
  Calculate Salaries and Bonus for `ResuelveFc`.
  """
  @minimum_goals_per_level %{
    "A" => 5,
    "B" => 10,
    "C" => 15,
    "Cuauh" => 20
  }

  def calculate_bonus(player) do
    individual_goal_achievement =
      case player["nivel"] do
        level when is_integer(level) -> player["goles"] / @minimum_goals_per_level[level]
        _ -> 0
      end

    team_goal_achievement =
      Enum.reduce([player["equipo"]], 0, fn _, acc ->
        acc + Map.get(player, "goles", 0)
      end) / 50

    individual_bonus = player["bono"] * individual_goal_achievement / 100
    team_bonus = player["bono"] * team_goal_achievement / 100
    total_bonus = individual_bonus + team_bonus

    player |> Map.put("sueldo_completo", player["sueldo"] + total_bonus)
  end

  def calculate_salaries(players) do
    Enum.map(players, &calculate_bonus/1)
  end
end
