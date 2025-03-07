defmodule SubmodalTestWeb.SubmodalLive.Input do
  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, assign(socket, :name, "")}
  end

  def render(assigns) do
    ~H"""
    <form phx-change="change" phx-target={@myself}>
      <input type="text" name="name" placeholder="Enter your name" class="rounded" />
      <p :if={String.length(@name) > 0}>Hello, {@name}!</p>
    </form>
    """
  end

  def handle_event("change", %{"name" => name}, socket) do
    {:noreply, assign(socket, :name, name)}
  end
end
