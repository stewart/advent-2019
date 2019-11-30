defmodule AOC.Helper do
  @input_dir Path.expand(__DIR__ <> "../../../data/")

  def load_input(date) do
    date = if is_integer(date), do: Integer.to_string(date), else: date
    case @input_dir |> Path.join(date) |> File.read() do
      {:ok, data} -> data
      error -> error
    end
  end

  def debug(value, opts \\ []), do: IO.inspect(value, opts)
end
