defmodule Helpers.FileReader do
  def read_file(filename) do
    File.read!("inputs/#{filename}")
  end
end
