defmodule TowerDefense.Game do
  alias TowerDefense.Player.Stats
  alias TowerDefense.Tower.Attributes
  alias TowerDefense.Monsters.Wave

  def gold do
    gold = Stats.get_my_stats().gold
    IO.puts "You have #{gold} gold!"
  end

  def life do
    life = Stats.get_my_stats().life
    IO.puts "You have #{life} life!"
  end

  def tower do
    tower = Attributes.get_tower_attributes()
    IO.puts "
    Tower level: #{tower.level}
    Damage: #{tower.damage}
    Upgrade cost: #{tower.upgrade_cost}
    "
  end

  def upgrade do
    Attributes.upgrade_tower
  end

  def wave do
    Wave.get_wave
  end

end