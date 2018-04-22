defmodule TowerDefense.Tower.Supervisor do
  use Supervisor
  alias TowerDefense.Tower.Attributes

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(Attributes, [])
    ]
    supervise(children, strategy: :one_for_all)
  end
end