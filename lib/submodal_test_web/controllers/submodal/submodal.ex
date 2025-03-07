defmodule SubmodalTestWeb.SubmodalLive.Submodal do
  use SubmodalTestWeb.Components.SubmodalRoot

  submodal(:one, default: true)
  submodal(:two)

  def mount(socket) do
    socket
    |> init_stack()
    |> then(&{:ok, &1})
  end

  def render(assigns) do
    assigns =
      Map.take(assigns, @submodals)
      |> then(&assign(assigns, submodals: &1))

    ~H"""
    <div>
      <%= for submodal <- @submodals do %>
        <%= if @current_submodal == elem(submodal, 0) do %>
          {render_slot(elem(submodal, 1), %{root: @myself})}
        <% end %>
      <% end %>

      <p>Current stack:</p>
      <ol>
        <li :for={submodal <- @submodal_stack}>{Atom.to_string(submodal)}</li>
      </ol>
      <button phx-click="push_submodal" phx-value-submodal="one" phx-target={@myself}>
        Push one
      </button>
      <button phx-click="push_submodal" phx-value-submodal="two" phx-target={@myself}>
        Push two
      </button>
      <button phx-click="pop_submodal" phx-target={@myself}>Pop</button>
    </div>
    """
  end
end
