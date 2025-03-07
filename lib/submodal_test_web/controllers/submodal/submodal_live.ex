defmodule SubmodalTestWeb.SubmodalLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    <.live_component module={SubmodalTestWeb.SubmodalLive.Submodal} id="submodal">
      <:one>hi</:one>
      <:two>hi again</:two>
    </.live_component>
    """
  end
end
