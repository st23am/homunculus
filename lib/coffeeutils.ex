defmodule Homunculus.CoffeeUtils do
	import Homunculus.PortUtils

  def get_version do
    open_port("coffee -v") |> process_port
  end

  def compile(file_path) do
    open_port("coffee -c -p #{file_path}")  |> process_port
  end
end
