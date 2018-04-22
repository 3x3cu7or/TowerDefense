defmodule TowerDefense.Supervisor do
  use Supervisor
  
  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end
  
  def init(_) do
    children = [
      supervisor(TowerDefense.Player.Supervisor, [])
    ]
    supervise(children, strategy: :one_for_all)
  end
end