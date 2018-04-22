defmodule TowerDefense.Supervisor do
  use Supervisor
  
  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end
  
  def init(_) do
    children = [
      supervisor(TowerDefense.Player.Supervisor, []),
      supervisor(TowerDefense.Monsters.Supervisor, []),
      supervisor(TowerDefense.Tower.Supervisor, [])
    ]
    supervise(children, strategy: :one_for_all)
  end
end