defmodule Homunculus.CLI do

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(args) do
      parse = OptionParser.parse(args, switches: [ help: :boolean],
                                                          aliases:    [ h:      :help     ])
      case parse do
        { [ help: true], _,   _} -> :help
        { _, [glob],            _} -> { glob }
        _                                -> :help
      end
  end

  def process(:help) do
    IO.puts """
    usage:  homunculus <glob>
    where glob is like "test/**/*.coffee"
    """
    System.halt(0)
  end

  def process(glob) do
    glob |> tuple_to_list |> Enum.join
    |> Homunculus.Watcher.start
  end

  def puts_success(msg) do
    IO.puts IO.ANSI.reset <>IO.ANSI.green <> msg <> IO.ANSI.reset
  end

  def puts_error(msg) do
      IO.puts IO.ANSI.reset <> IO.ANSI.red <> msg <> IO.ANSI.reset
  end
end