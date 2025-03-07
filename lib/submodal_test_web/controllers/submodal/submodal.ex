defmodule SubmodalTestWeb.SubmodalLive.Submodal do
  use SubmodalTestWeb.Components.SubmodalRoot

  submodal(:counter, default: true)
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
    <div class="border flex min-h-96">
      <div class="flex-1 flex items-center justify-center">
        <%= for submodal <- @submodals do %>
          <%= if @current_submodal == elem(submodal, 0) do %>
            {render_slot(elem(submodal, 1), %{root: @myself})}
          <% end %>
        <% end %>
      </div>

      <div class="px-5 py-3 border-l flex flex-col justify-between">
        <p>
          Current submodal: <span class="text-brand">:{@current_submodal |> Atom.to_string()}</span>
        </p>
        <p class="font-medium text-xl">Current stack:</p>
        <ol class="flex flex-col gap-1 justify-end flex-1 pb-8">
          <li
            :for={submodal <- @submodal_stack}
            class="first:bg-brand/50 first:font-semibold w-full text-center py-1 bg-gray-100 rounded"
          >
            :{Atom.to_string(submodal)}
          </li>
        </ol>
        <div class="flex gap-1">
          <button
            phx-click="push_submodal"
            phx-value-submodal="counter"
            phx-target={@myself}
            class="px-2 py-1 bg-brand rounded font-medium text-white"
          >
            :counter
          </button>
          <button
            phx-click="pop_submodal"
            phx-target={@myself}
            class="border px-2 py-1 rounded"
            disabled={Enum.empty?(@submodal_stack)}
          >
            Pop
          </button>
          <button
            phx-click="push_submodal"
            phx-value-submodal="two"
            phx-target={@myself}
            class="px-2 py-1 bg-brand rounded font-medium text-white"
          >
            Push :two
          </button>
        </div>
      </div>
    </div>
    """
  end
end
