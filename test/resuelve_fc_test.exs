defmodule ResuelveFcTest do
  use ExUnit.Case
  alias ResuelveFc

  describe "ResuelveFc test" do
    test "When receive only from one team should return excpected result" do
      input_json = %{
        "jugadores" => [
          %{
            "bono" => 25000,
            "equipo" => "rojo",
            "goles" => 10,
            "nivel" => "C",
            "nombre" => "Juan Perez",
            "sueldo" => 50000,
            "sueldo_completo" => nil
          },
          %{
            "bono" => 30000,
            "equipo" => "azul",
            "goles" => 30,
            "nivel" => "Cuauh",
            "nombre" => "EL Cuauh",
            "sueldo" => 100_000,
            "sueldo_completo" => nil
          },
          %{
            "bono" => 10000,
            "equipo" => "azul",
            "goles" => 7,
            "nivel" => "A",
            "nombre" => "Cosme Fulanito",
            "sueldo" => 20000,
            "sueldo_completo" => nil
          },
          %{
            "bono" => 15000,
            "equipo" => "rojo",
            "goles" => 9,
            "nivel" => "B",
            "nombre" => "El Rulo",
            "sueldo" => 30000,
            "sueldo_completo" => nil
          }
        ]
      }

      output = [
        %{
          "bono" => 25000,
          "equipo" => "rojo",
          "goles" => 10,
          "nivel" => "C",
          "nombre" => "Juan Perez",
          "sueldo" => 50000,
          "sueldo_completo" => 50050.0
        },
        %{
          "bono" => 30000,
          "equipo" => "azul",
          "goles" => 30,
          "nivel" => "Cuauh",
          "nombre" => "EL Cuauh",
          "sueldo" => 100_000,
          "sueldo_completo" => 100_180.0
        },
        %{
          "bono" => 10000,
          "equipo" => "azul",
          "goles" => 7,
          "nivel" => "A",
          "nombre" => "Cosme Fulanito",
          "sueldo" => 20000,
          "sueldo_completo" => 20014.0
        },
        %{
          "bono" => 15000,
          "equipo" => "rojo",
          "goles" => 9,
          "nivel" => "B",
          "nombre" => "El Rulo",
          "sueldo" => 30000,
          "sueldo_completo" => 30027.0
        }
      ]

      result = ResuelveFc.calculate_salaries(input_json["jugadores"])
      assert result == output
    end

    test "When receive input from different teams should return expected result " do
      input = %{
        "equipos" => [
          %{
            "nombre_equipo" => "Resuelve FC",
            "jugadores" => [
              %{
                "nombre" => "Player 1",
                "nivel" => "A",
                "equipo" => "rojo",
                "goles" => 8,
                "bono" => 5000,
                "sueldo" => 20000
              },
              %{
                "nombre" => "Player 2",
                "nivel" => "B",
                "equipo" => "azul",
                "goles" => 15,
                "bono" => 8000,
                "sueldo" => 25000
              },
              %{
                "nombre" => "Player 3",
                "nivel" => "C",
                "equipo" => "verde",
                "goles" => 20,
                "bono" => 10000,
                "sueldo" => 30000
              },
              %{
                "nombre" => "Player 4",
                "nivel" => "Cuauh",
                "equipo" => "rojo",
                "goles" => 25,
                "bono" => 12000,
                "sueldo" => 35000
              }
            ]
          },
          %{
            "nombre_equipo" => "Otro Equipo",
            "jugadores" => [
              %{
                "nombre" => "Player 5",
                "nivel" => "A",
                "equipo" => "azul",
                "goles" => 10,
                "bono" => 6000,
                "sueldo" => 22000
              },
              %{
                "nombre" => "Player 6",
                "nivel" => "B",
                "equipo" => "verde",
                "goles" => 18,
                "bono" => 9000,
                "sueldo" => 27000
              },
              %{
                "nombre" => "Player 7",
                "nivel" => "C",
                "equipo" => "rojo",
                "goles" => 22,
                "bono" => 11000,
                "sueldo" => 32000
              }
            ]
          }
        ]
      }

      output = [
        %{
          "bono" => 5000,
          "equipo" => "rojo",
          "goles" => 8,
          "nivel" => "A",
          "nombre" => "Player 1",
          "sueldo" => 20000,
          "sueldo_completo" => 20008.0
        },
        %{
          "bono" => 8000,
          "equipo" => "azul",
          "goles" => 15,
          "nivel" => "B",
          "nombre" => "Player 2",
          "sueldo" => 25000,
          "sueldo_completo" => 25024.0
        },
        %{
          "bono" => 10000,
          "equipo" => "verde",
          "goles" => 20,
          "nivel" => "C",
          "nombre" => "Player 3",
          "sueldo" => 30000,
          "sueldo_completo" => 30040.0
        },
        %{
          "bono" => 12000,
          "equipo" => "rojo",
          "goles" => 25,
          "nivel" => "Cuauh",
          "nombre" => "Player 4",
          "sueldo" => 35000,
          "sueldo_completo" => 35060.0
        },
        %{
          "bono" => 6000,
          "equipo" => "azul",
          "goles" => 10,
          "nivel" => "A",
          "nombre" => "Player 5",
          "sueldo" => 22000,
          "sueldo_completo" => 22012.0
        },
        %{
          "bono" => 9000,
          "equipo" => "verde",
          "goles" => 18,
          "nivel" => "B",
          "nombre" => "Player 6",
          "sueldo" => 27000,
          "sueldo_completo" => 27032.4
        },
        %{
          "bono" => 11000,
          "equipo" => "rojo",
          "goles" => 22,
          "nivel" => "C",
          "nombre" => "Player 7",
          "sueldo" => 32000,
          "sueldo_completo" => 32048.4
        }
      ]


      players = Enum.flat_map(input["equipos"], fn equipo ->
        equipo["jugadores"]
      end)

      result = ResuelveFc.calculate_salaries(players)
      assert result == output
    end
  end
end
