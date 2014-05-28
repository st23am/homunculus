defmodule Homunculus.PortUtils do
  def open_port(command) do
    Port.open({:spawn, command}, [:stderr_to_stdout, :exit_status])
  end

  def process_port(port) do
    {_status, data} = collect_output(port, [])
    data
  end

  defp collect_output(port, data) do
    receive do
      {^port, {:data, new_data}} ->
        collect_output(port, [data, new_data])
      {^port, {:exit_status, status}} ->
        { status, List.to_string(data) }
      after 3000 ->
        {:error, "Time out"}
    end
  end
end
