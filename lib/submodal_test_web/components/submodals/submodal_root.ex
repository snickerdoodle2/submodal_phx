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

  defmacro __using__(_) do
    this = __MODULE__

    quote do
      use Phoenix.LiveComponent
      import unquote(this)

      @submodals []
      @default_submodal nil
    end
  end
end
