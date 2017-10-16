defmodule Eslixir.RedisEventStore do
  def commit(_uuid, []), do: nil
  def commit(uuid, [event | events]) do
    {:ok, _} = Redix.command(:redix, ["RPUSH", uuid, event])
    commit(uuid, events)
  end

  def load(uuid) do
    {:ok, result} = Redix.command(:redix, ~w(LRANGE #{uuid} 0 -1))
    result
  end
end
