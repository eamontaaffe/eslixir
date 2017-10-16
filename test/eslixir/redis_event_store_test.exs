defmodule RedisEventStoreTest do
  use ExUnit.Case

  alias Eslixir.RedisEventStore

  @events ["Event1", "Event2"]
  @uuid "abc123"

  setup do
    Redix.command(:redix, ["FLUSHALL"])
    :ok
  end

  test "commit/1" do
    res = RedisEventStore.commit(@uuid, @events)
    assert res == nil
  end

  test "load/1" do
    RedisEventStore.commit(@uuid, @events)
    res = RedisEventStore.load(@uuid)
    assert res == @events
  end
end
