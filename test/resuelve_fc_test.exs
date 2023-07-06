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
  end
end
