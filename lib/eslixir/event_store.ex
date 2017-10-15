defmodule Eslixir.EventStore do
  @moduledoc ~S"""
  The EventStore stores events in the event store, and notifies listeners via
  EventHandler. It has only two functions. commit will add events to a
  particular aggregate, identified by its uuid. load simply loads events from a
  particular aggregate.
  """

  @event_store RedisEventStore

  alias Eslixir.EventSerializer
  alias Eslixir.EventHandler

  def commit(uuid, events) when is_list(events) do
    serialized_events =
      events
      |> Enum.map(&EventSerializer.serialize/1)

    @event_store.commit(uuid, serialized_events)
  end
  def commit(uuid, event), do: commit(uuid, [event])

  def load(uuid), do
    events =
      @event_store.load(uuid)
      |> Enum.map(&EventSerializer.deserialize/1)
  end

  defp notify(_uuid, []), do: :ok
  defp notify(uuid, [evet | events]) do
    EventHandler.handle({uuid, events})
    notify(uuid, events)
  end
end
