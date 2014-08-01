defmodule Homunculus.FileUtils do
  def concat_content(content_list, target) do
    content = Enum.join(content_list, "\n")
    IO.puts "Concating sources into #{target}"
    case File.write(target, content) do
      :ok ->  Homunculus.CLI.puts_notice("All done operation was Successful")
      _    -> Homunculus.CLI.puts_error("Something went wrong writing the file!")
    end
  end
end