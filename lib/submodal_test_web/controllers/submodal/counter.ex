defmodule SubmodalTestWeb.SubmodalLive.Counter do
  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col gap-1 items-center">
      <p>Current count: <span>{@count}</span></p>
      <div class="flex gap-2">
        <button
          phx-click="inc"
          phx-target={@myself}
          class="bg-brand text-white font-medium px-8 py-1 rounded"
        >
          +
        </button>
        <button phx-click="dec" phx-target={@myself} class="border font-medium px-8 py-1 rounded">
          -
        </button>
      </div>
    </div>
    """
  end

  def handle_event("inc", _, socket) do
    socket
    |> update(:count, &(&1 + 1))
    |> then(&{:noreply, &1})
  end

  def handle_event("dec", _, socket) do
    socket
    |> update(:count, &(&1 - 1))
    |> then(&{:noreply, &1})
  end
end
