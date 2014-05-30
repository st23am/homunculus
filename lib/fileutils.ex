defmodule Homunculus.FileUtils do
  def concat_content(content_list, target) do
    content = Enum.join(content_list, "\n")
    File.write!(target, content)
  end
end