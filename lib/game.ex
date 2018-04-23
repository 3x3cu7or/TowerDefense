defmodule TowerDefense.Game do
  alias TowerDefense.Player.Stats
  alias TowerDefense.Tower.Attributes
  alias TowerDefense.Monsters.Wave

  def help do
    IO.puts "
    Commands:
      .player - returns player info
      .tower - returns tower info
      .wave - return next wave info

      .upgrade - upgrades tower
      .send_wave - sends next wave
    "
  end

  def player do
    Stats.get_my_stats()
  end

  def tower do
    Attributes.get_tower_attributes()
  end

  def wave do
    Wave.get_wave
  end

  def upgrade do
    Attributes.upgrade_tower
  end

  def send_wave do
    for _n <- 1..7 do
      fight()
    end
    monsters = Wave.get_wave.monsters
    for _monster <- monsters do
      Stats.modify_my_life(-10)
    end

    :timer.sleep(1000)    
    if length(monsters) == 0 do
      IO.puts "\nYou killed all monsters!\n"
    else
      IO.puts "\nYou failed to kill all monsters!\n"
      IO.puts "Remaining monster: "
      IO.inspect monsters
    end
    Wave.increase_level
    IO.puts "\nNext wave is prepared!\n"
  end

  def fight() do
    monsters = Wave.get_wave.monsters
    damage = Attributes.get_tower_attributes.damage
    if length(monsters) > 0 do
      :timer.sleep(1000)
      IO.puts ""
      IO.inspect monsters
      IO.puts ""
      Wave.decrease_life(damage)
    end
  end

end