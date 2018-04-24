defmodule TowerDefense.Player.Supervisor do
  use Supervisor
  alias TowerDefense.Player.Stats

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(Stats, [])
    ]
    supervise(children, strategy: :one_for_one)
  end
end