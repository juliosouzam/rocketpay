defmodule Rocketpay.Numbers do
  def sum_from_file(file_name) do
    "#{file_name}.csv"
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, file}) do
    file =
      file
      |> String.split(",")
      |> Stream.map(fn n -> String.to_integer(n) end)
      |> Enum.sum()

    {:ok, %{file: file}}
  end

  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid file"}}
end
