defmodule TowerDefense.Monsters.Wave do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :wave_process)
  end

  def init(_initial_data) do
    IO.puts "Started monsters module!"
    level = 1
    monster = %{life: 10 + (5*level)}
    monsters = [monster, monster, monster, monster, monster]
    wave = %{level: level, monsters: monsters}
    
    {:ok, wave}
  end

  def get_wave() do
    GenServer.call(:wave_process, {:get_my_wave})
  end

  def increase_wave_level do
    GenServer.call(:wave_process, {:increase_level})
  end

  def handle_call({:get_my_wave}, _from, my_state) do
    {:reply, my_state, my_state}
  end

  def handle_call({:increase_level}, _from, my_state) do
    old_level = my_state.level
    level = old_level + 1
    monster = %{life: 10 + (5*level)}
    monsters = [monster, monster, monster, monster, monster]
    new_state = %{level: level, monsters: monsters}
    {:reply, new_state, new_state}
  end
end