defmodule EventSerializerTest do
  use ExUnit.Case

  alias Eslixir.EventSerializer

  defmodule Event, do: defstruct [:id, :payload]

  @s_event """
  {\"payload\":\"Foo\",\
  \"id\":1,\
  \"__struct__\":\"Elixir.EventSerializerTest.Event\"}\
  """

  test "serialize/1" do
    s_event = EventSerializer.serialize(%Event{id: 1, payload: "Foo"})
    assert s_event == @s_event
  end

  test "deserialize/1" do
    d_event = EventSerializer.deserialize(@s_event)
    assert d_event == %Event{id: 1, payload: "Foo"}
  end
end
