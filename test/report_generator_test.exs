defmodule ReportGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      file_name = "report_test.csv"

      response = ReportGenerator.build(file_name)

      expected_response = %{
        "foods" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pastel" => 0,
          "pizza" => 2,
          "prato_feito" => 0,
          "sushi" => 0
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 45,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 31,
          "30" => 0,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert response == expected_response
    end
  end

  describe "build_from_many/1" do
    test "builds the report from many files" do
      file_names = ["report_test.csv", "report_test.csv", "report_test.csv"]

      response = ReportGenerator.build_from_many(file_names)

      expected_response = {
        :ok,
        %{
          "foods" => %{
            "açaí" => 3,
            "churrasco" => 6,
            "esfirra" => 9,
            "hambúrguer" => 6,
            "pastel" => 0,
            "pizza" => 6,
            "prato_feito" => 0,
            "sushi" => 0
          },
          "users" => %{
            "1" => 144,
            "10" => 108,
            "11" => 0,
            "12" => 0,
            "13" => 0,
            "14" => 0,
            "15" => 0,
            "16" => 0,
            "17" => 0,
            "18" => 0,
            "19" => 0,
            "2" => 135,
            "20" => 0,
            "21" => 0,
            "22" => 0,
            "23" => 0,
            "24" => 0,
            "25" => 0,
            "26" => 0,
            "27" => 0,
            "28" => 0,
            "29" => 0,
            "3" => 93,
            "30" => 0,
            "4" => 126,
            "5" => 147,
            "6" => 54,
            "7" => 81,
            "8" => 75,
            "9" => 72
          }
        }
      }

      assert response == expected_response
    end

    test "when a file name is not provided, returns an error" do
      file_names = "worng file name"

      response = ReportGenerator.build_from_many(file_names)

      expected_response = {:error, "Please provide a list of filenames"}

      assert response == expected_response
    end
  end

  describe "fetch_higher_cost/2" do
    test "when the option is 'users', return the user who spent the most" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportGenerator.build()
        |> ReportGenerator.fetch_higher_cost("users")

      expected_response = {:ok, {"5", 49}}

      assert response == expected_response
    end

    test "when the option is 'foods', return the most consumed food" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportGenerator.build()
        |> ReportGenerator.fetch_higher_cost("foods")

      expected_response = {:ok, {"esfirra", 3}}

      assert response == expected_response
    end

    test "when an invalid option is given, returns an error" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportGenerator.build()
        |> ReportGenerator.fetch_higher_cost("here is an invalid option")

      expected_response = {:error, "Invalid option"}

      assert response == expected_response
    end
  end
end
