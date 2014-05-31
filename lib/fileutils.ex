defmodule Homunculus.FileUtils do
  def concat_content(content_list, target) do
    content = Enum.join(content_list, "\n")
    IO.puts "Concating sources into #{target}"
    File.write!(target, content)
  end

  def last_modified(path) do
    case File.stat(path) do
      {:ok, %File.Stat{mtime: mtime}} -> mtime
      {:error, _} -> {{1970, 1, 1}, {0, 0, 0}}
    end
  end
end