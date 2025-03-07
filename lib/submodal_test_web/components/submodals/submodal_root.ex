defmodule SubmodalTestWeb.Components.SubmodalRoot do
  defmacro submodal(name, opts \\ []) do
    quote do
      default = Keyword.get(unquote(opts), :default, false)

      if default do
        Module.put_attribute(__MODULE__, :default_submodal, unquote(name))
      end

      Module.put_attribute(__MODULE__, :submodals, [unquote(name) | @submodals])
      slot unquote(name)
    end
  end

  defmacro init_stack(socket) do
    quote do
      unquote(socket)
      |> assign(current_submodal: @default_submodal)
      |> assign(submodal_stack: [])
    end
  end

  defmacro __using__(_) do
    this = __MODULE__

    quote do
      use Phoenix.LiveComponent
      import unquote(this)

      @submodals []
      @default_submodal nil

      def handle_event(
            "push_submodal",
            %{"submodal" => submodal},
            %{assigns: %{current_submodal: current_submodal}} = socket
          ) do
        submodal = submodal |> String.to_existing_atom()

        socket
        |> update(:submodal_stack, &[current_submodal | &1])
        |> assign(:current_submodal, submodal)
        |> then(&{:noreply, &1})
      end

      def handle_event(
            "pop_submodal",
            _,
            %{assigns: %{submodal_stack: [previous | stack]}} = socket
          ) do
        socket
        |> assign(:current_submodal, previous)
        |> assign(:submodal_stack, stack)
        |> then(&{:noreply, &1})
      end
    end
  end
end
