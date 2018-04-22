defmodule TowerDefense do
  use Application

  def start(_type, _args) do
    TowerDefense.Supervisor.start_link
  end
end
