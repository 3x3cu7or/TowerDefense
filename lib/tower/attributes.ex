defmodule TowerDefense.Tower.Attributes do
  use GenServer
  alias TowerDefense.Player

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :tower_process)
  end

  def init(_initial_data) do
    IO.puts "Started tower module!"    
    level = 1
    damage = 5 + 5*level
    upgrade_cost = 50*level
    attributes = %{level: level, damage: damage, upgrade_cost: upgrade_cost}
    {:ok, attributes}
  end

  def upgrade_tower() do
    player_gold = Player.Stats.get_my_stats.gold
    upgrade_cost = get_tower_attributes().upgrade_cost
    case player_gold < upgrade_cost do
      true -> IO.puts "Not enough gold!"
      false -> upgrade(upgrade_cost)
    end
  end

  def upgrade(upgrade_cost) do
    increase_level()
    Player.Stats.modify_my_gold(0-upgrade_cost)
    IO.puts "Tower upgraded!"
  end

  def get_tower_attributes() do
    GenServer.call(:tower_process, {:get_tower_attributes})
  end

  def increase_level() do
    GenServer.call(:tower_process, {:increase_level})
  end

  def handle_call({:get_tower_attributes}, _from, tower_attributes) do
    {:reply, tower_attributes, tower_attributes}
  end

  def handle_call({:increase_level}, _from, tower_attributes) do
    old_level = tower_attributes.level
    level = old_level + 1
    damage = 10 + 5*level
    upgrade_cost = 50*level
    new_attributes = %{level: level, damage: damage, upgrade_cost: upgrade_cost}
    {:reply, new_attributes, new_attributes}
  end

end