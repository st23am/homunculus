defmodule Homunculus.Watcher do
  import Homunculus.CoffeeUtils
  import Homunculus.FileUtils

  def start(glob) do
    glob |> Path.wildcard  |> start_file_agent
    IO.puts "Watchings for files that match #{glob}..."
    watch(glob)
  end

  def watch(glob) do
    files = Path.wildcard(glob)
    if check_for_changes(files) do
      perform_task(files, "test/fixtures/app.js")
    end
    watch(glob)
  end

  def perform_task(files, target) do
    Enum.map(files, fn(file) ->
                      Task.async(Homunculus.CoffeeUtils, :compile, [file]) end)
    |> Enum.map(fn(task) -> Task.await(task) end)
    |> Homunculus.FileUtils.concat_content(target)
  end

  def check_for_changes(files) do
     Enum.any?(files, fn(file) -> file_changed?(file) end)
  end

  def set_initial_state(files) do
    Enum.map(files, fn(file) -> {file, Mix.Utils.last_modified(file)} end) |> Enum.into HashDict.new
  end

  def start_file_agent(files)  do
    Agent.start_link(fn -> set_initial_state(files) end, name: Files)
  end

  def add_or_update_file(file) do
    value = Mix.Utils.last_modified(file)
    Agent.update(Files, fn(dict) -> HashDict.put(dict, file, value) end)
  end

  def file_changed?(file) do
    new_value = Mix.Utils.last_modified(file)
    previous_value = Agent.get(Files,  fn(dict) -> HashDict.get(dict, file)  end)
    changed? = new_value != previous_value
    if changed? do
      add_or_update_file(file)
      IO.puts("File #{file} changed recompiling")
    end
    changed?
  end
end