defmodule Homunculus.FileUtils do
  def concat_content(content_list, target) do
    content = Enum.join(content_list, "\n")
    IO.puts "Concating sources into #{target}"
    File.write!(target, content)
  end
end