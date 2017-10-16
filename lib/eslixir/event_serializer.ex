defmodule Eslixir.EventSerializer do
  def serialize(event) do
    event
    |> Map.from_struct
    |> Map.merge(%{__struct__: to_string(event.__struct__)})
    |> Poison.encode!
  end

  def deserialize(s_event) do
    s_event
    |> Poison.decode!(keys: :atoms)
    |> decode()
  end

  def decode(event_map) do
    new_event =
      event_map
      |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, key, val) end)

    [Map.fetch!(new_event, :__struct__)]
    |> Module.concat()
    |> struct(new_event)
  end
end
