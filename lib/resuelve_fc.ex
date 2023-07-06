defmodule ResuelveFc do
  @moduledoc """
  Calculate Salaries and Bonus for `ResuelveFc`.
  """
  @minimum_goals_per_level %{
    "A" => %{"rojo" => 5, "azul" => 6, "verde" => 7},
    "B" => %{"rojo" => 10, "azul" => 11, "verde" => 12},
    "C" => %{"rojo" => 15, "azul" => 16, "verde" => 17},
    "Cuauh" => %{"rojo" => 20, "azul" => 21, "verde" => 22}
  }

  def calculate_bonus(player) do
    individual_goal_achievement =
      case player["nivel"] do
        level when is_integer(level) ->
          min_goals = Map.fetch!(@minimum_goals_per_level, level)
          min_goals_team = Map.fetch!(min_goals, player["equipo"])
          player["goles"] / min_goals_team

        _ ->
          0
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
