defmodule Doggo.Storybook.MenuButton do
  @moduledoc false
  alias PhoenixStorybook.Stories.Variation

  def template do
    """
    <div>
      <.psb-variation/>
      <Doggo.menu id="actions-menu" labelledby="actions-button" hidden>
        <:item>Copy</:item>
        <:item>Paste</:item>
        <:item role="separator"></:item>
        <:item>Sort lines</:item>
      </Doggo.menu>
    </div>
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        attributes: %{
          controls: "actions-menu",
          id: "actions-button"
        },
        slots: ["Actions"]
      }
    ]
  end

  def modifier_variation_base(id, _name, _value) do
    %{
      attributes: %{
        id: id,
        controls: "actions-menu"
      },
      slots: ["Actions"]
    }
  end
end