defmodule TowerDefense.Player.Stats do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :player_process)
  end

  def init(_initial_data) do
    IO.puts "Started player module!"
    stats = %{life: 100, gold: 100}
    {:ok, stats}
  end

  def get_my_stats() do
    GenServer.call(:player_process, {:get_the_stats})
  end

  def modify_my_life(amount) do
    GenServer.call(:player_process, {:modify_the_life, amount})
  end

  def modify_my_gold(amount) do
    GenServer.call(:player_process, {:modify_the_gold, amount})
  end

  def handle_call({:get_the_stats}, _from, my_stats) do
    {:reply, my_stats, my_stats}
  end

  def handle_call({:modify_the_life, amount}, _from, my_stats) do
    %{life: old_life} = my_stats
    new_stats = Map.put(my_stats, :life, old_life + amount)
    {:reply, new_stats, new_stats}
  end

  def handle_call({:modify_the_gold, amount}, _from, my_stats) do
    %{gold: old_gold} = my_stats
    new_stats = Map.put(my_stats, :gold, old_gold + amount)
    {:reply, new_stats, new_stats}
  end
end