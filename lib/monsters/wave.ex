defmodule TowerDefense.Monsters.Wave do
  use GenServer
  alias TowerDefense.Player.Stats

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :wave_process)
  end

  def init(_initial_data) do
    IO.puts "Started monsters module!"
    level = 1
    monster = %{life: 10 + 5*level, reward: 10 + 5*level}
    monsters = [monster, monster, monster, monster, monster]
    wave = %{level: level, monsters: monsters}
    
    {:ok, wave}
  end

  def get_wave() do
    GenServer.call(:wave_process, {:get_my_wave})
  end

  def increase_level() do
    GenServer.call(:wave_process, {:increase_level})
  end

  def decrease_life(amount) do
    GenServer.call(:wave_process, {:decrease_life, amount})
  end

  def handle_call({:get_my_wave}, _from, my_state) do
    {:reply, my_state, my_state}
  end

  def handle_call({:increase_level}, _from, my_state) do
    old_level = my_state.level
    level = old_level + 1
    monster = %{life: 10 + 5*level, reward: 10 + level}
    monsters = [monster, monster, monster, monster, monster]
    new_state = %{level: level, monsters: monsters}
    {:reply, [], new_state}
  end

  def handle_call({:decrease_life, amount}, _from, my_state) do
    monsters = my_state.monsters
    level = my_state.level
    monster = List.last(monsters)
    monster_life = monster.life
    monster_reward = monster.reward

    if monster_life <= amount do
      new_monsters = List.delete_at(monsters, length(monsters)-1)
      new_state = %{level: level, monsters: new_monsters}
      Stats.modify_my_gold(monster_reward)
     {:reply, new_monsters, new_state}
    else
      new_monster = %{monster | life: monster.life - amount}
      new_monsters = List.replace_at(monsters, length(monsters)-1, new_monster)
      new_state = %{level: level, monsters: new_monsters}
      {:reply, new_monsters, new_state}
    end


  end
end