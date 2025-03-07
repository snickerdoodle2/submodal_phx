defmodule SubmodalTestWeb.SubmodalLive do
  use SubmodalTestWeb, :live_view

  def render(assigns) do
    ~H"""
    <.live_component module={SubmodalTestWeb.SubmodalLive.Submodal} id="submodal">
      <:one>hi</:one>
      <:two>hi again</:two>
    </.live_component>
    """
  end
end
