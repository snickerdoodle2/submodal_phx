defmodule SubmodalTestWeb.SubmodalLive.Submodal do
  use SubmodalTestWeb.Components.SubmodalRoot

  submodal(:one, default: true)
  submodal(:two)

  def mount(socket) do
    socket
    |> assign(current_submodal: @default_submodal)
    |> then(&{:ok, &1})
  end

  def render(assigns) do
    assigns =
      Map.take(assigns, @submodals)
      |> then(&assign(assigns, submodals: &1))

    ~H"""
    <div>
      <p>Submodals!</p>

      <%= for submodal <- @submodals do %>
        <%= if @current_submodal == elem(submodal, 0) do %>
          {render_slot(elem(submodal, 1), %{root: @myself})}
        <% end %>
      <% end %>
    </div>
    """
  end
end
