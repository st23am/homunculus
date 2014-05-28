defmodule HomunculusTest do
  use ExUnit.Case
  alias Homunculus.CoffeeUtils, as: CoffeeUtils

  test "coffeescript should be installed" do
    assert CoffeeUtils.get_version() == "CoffeeScript version 1.7.1\n"
  end

  test "compiling a simple coffeescript file" do
    coffee_fixture = "test/fixtures/foo.coffee"
    {_, js_fixture} = File.read("test/fixtures/foo.js")
    assert(CoffeeUtils.compile(coffee_fixture) == js_fixture)
  end
end
