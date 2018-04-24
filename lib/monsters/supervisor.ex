defmodule TowerDefense.Monsters.Supervisor do
  use Supervisor
  alias TowerDefense.Monsters.Wave

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(Wave, [])
    ]
    supervise(children, strategy: :one_for_all)
  end
end