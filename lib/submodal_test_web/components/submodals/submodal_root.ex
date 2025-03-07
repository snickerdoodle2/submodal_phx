defmodule SubmodalTestWeb.Components.SubmodalRoot do
  @moduledoc """
  Rough idea for SubModalRoot component

  this module handles logic of swapping components while traversing the modal

  it was the first time I've ever wrote __using__/1 macro so it's easy to break (i think)

  using attributes is weird :(
  eg. submodal/2 macro has to be called above init_stack/1 macro

  slot compile time checking would be nice

  navigate_submodal/1 macro would be great :D
  """

  @doc """
  opts ideas:
  - children: checking if given path is reachable (no weird bugs)
  - title
  - preserve (idk how to call it): do not unmount this if it's not the current submodal
  (does not lose state igs), just hide it from the DOM
  """
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
