defmodule TowerDefense do
  use Application

  def start(_type, _args) do
    IO.puts "Run Game.help for info"
    TowerDefense.Supervisor.start_link
  end
end
